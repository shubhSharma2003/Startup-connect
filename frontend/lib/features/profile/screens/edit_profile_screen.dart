import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/widgets/auth_text_field.dart';
import '../providers/profile_provider.dart';
import '../widgets/skills_chip_section.dart';
import '../widgets/portfolio_links_section.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _headlineController;
  late TextEditingController _bioController;

  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _linkTitleController = TextEditingController();
  final TextEditingController _linkUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider).value;
    _firstNameController = TextEditingController(text: profile?.firstName ?? '');
    _lastNameController = TextEditingController(text: profile?.lastName ?? '');
    _headlineController = TextEditingController(text: profile?.headline ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _headlineController.dispose();
    _bioController.dispose();
    _skillController.dispose();
    _linkTitleController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(profileProvider.notifier).updateProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        headline: _headlineController.text.trim(),
        bio: _bioController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully'), backgroundColor: AppColors.success),
      );
      context.pop();
    }
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final success = await ref.read(profileProvider.notifier).uploadAvatar(image);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Avatar uploaded')));
      }
    }
  }

  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      final success = await ref.read(profileProvider.notifier).uploadResume(result.files.first);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resume uploaded')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final profile = profileState.value;

    if (profile == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BaseScaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar Section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      backgroundImage: profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
                      child: profile.avatarUrl == null ? const Icon(Icons.person, size: 50, color: AppColors.primary) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickAvatar,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              AuthTextField(
                label: 'First Name',
                hint: 'First Name',
                prefixIcon: Icons.person_outline,
                controller: _firstNameController,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Last Name',
                hint: 'Last Name',
                prefixIcon: Icons.person_outline,
                controller: _lastNameController,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Headline',
                hint: 'e.g. Flutter Developer',
                prefixIcon: Icons.title,
                controller: _headlineController,
              ),
              const SizedBox(height: 16),
              Text(
                'Bio',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _bioController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Tell us about yourself...',
                ),
              ),
              const SizedBox(height: 32),

              // Resume Section
              const Text('Resume', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.upload_file, color: AppColors.primary),
                title: Text(profile.resumeUrl != null ? 'Update Resume (PDF)' : 'Upload Resume (PDF)'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _pickResume,
              ),
              const Divider(),
              const SizedBox(height: 24),

              // Skills Section
              const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              SkillsChipSection(
                skills: profile.skills,
                isEditing: true,
                onRemove: (id) => ref.read(profileProvider.notifier).removeSkill(id),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _skillController,
                      decoration: const InputDecoration(hintText: 'Add a skill (e.g. Dart)', prefixIcon: Icon(Icons.star_outline, size: 20)),
                      onFieldSubmitted: (val) {
                        if (val.trim().isNotEmpty) {
                          ref.read(profileProvider.notifier).addSkill(val.trim());
                          _skillController.clear();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 32),
                    onPressed: () {
                      if (_skillController.text.trim().isNotEmpty) {
                        ref.read(profileProvider.notifier).addSkill(_skillController.text.trim());
                        _skillController.clear();
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 32),

              // Portfolio Section
              const Text('Portfolio & Links', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              PortfolioLinksSection(
                links: profile.portfolioLinks,
                isEditing: true,
                onRemove: (id) => ref.read(profileProvider.notifier).removePortfolioLink(id),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _linkTitleController,
                      decoration: const InputDecoration(hintText: 'Title (e.g. GitHub)', prefixIcon: Icon(Icons.title, size: 16)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _linkUrlController,
                      decoration: const InputDecoration(hintText: 'URL', prefixIcon: Icon(Icons.link, size: 16)),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 32),
                    onPressed: () {
                      if (_linkTitleController.text.trim().isNotEmpty && _linkUrlController.text.trim().isNotEmpty) {
                        ref.read(profileProvider.notifier).addPortfolioLink(_linkTitleController.text.trim(), _linkUrlController.text.trim());
                        _linkTitleController.clear();
                        _linkUrlController.clear();
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

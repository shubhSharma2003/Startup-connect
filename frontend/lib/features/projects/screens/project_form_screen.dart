import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/widgets/auth_text_field.dart';
import '../providers/project_form_provider.dart';
import '../providers/project_details_provider.dart';
import '../widgets/project_image_picker.dart';
import '../../profile/widgets/skills_chip_section.dart'; // Reuse from profile
import '../../profile/models/skill_model.dart';

class ProjectFormScreen extends ConsumerStatefulWidget {
  final String? projectId; // If null, it's create mode. If provided, it's edit mode.

  const ProjectFormScreen({super.key, this.projectId});

  @override
  ConsumerState<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends ConsumerState<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _maxTeamSizeController;
  final TextEditingController _skillController = TextEditingController();

  List<String> _requiredSkills = [];
  XFile? _coverImage;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _maxTeamSizeController = TextEditingController(text: '5');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      if (widget.projectId != null) {
        // Edit mode - prefill data
        final existingData = ref.read(projectDetailsProvider(widget.projectId!)).value;
        if (existingData != null) {
          _titleController.text = existingData.title;
          _descriptionController.text = existingData.fullDescription;
          _maxTeamSizeController.text = existingData.maxTeamSize.toString();
          _requiredSkills = List.from(existingData.requiredSkills);
        }
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _maxTeamSizeController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _coverImage = image;
      });
    }
  }

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty && !_requiredSkills.contains(skill)) {
      setState(() {
        _requiredSkills.add(skill);
      });
      _skillController.clear();
    }
  }

  void _removeSkill(int index) {
    setState(() {
      _requiredSkills.removeAt(index);
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'maxTeamSize': int.parse(_maxTeamSizeController.text),
        'requiredSkills': _requiredSkills,
        // In real app, you would upload _coverImage to S3 here first or pass file path
      };

      final success = await ref.read(projectFormProvider.notifier).submitForm(
        projectId: widget.projectId,
        data: data,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.projectId == null ? 'Project created!' : 'Project updated!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.projectId != null;
    final formState = ref.watch(projectFormProvider);
    final isLoading = formState is AsyncLoading;

    // Convert string skills to models for the reused widget
    final skillModels = _requiredSkills.asMap().entries.map((e) => SkillModel(id: e.key, name: e.value)).toList();

    return BaseScaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Project' : 'Create Project'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProjectImagePicker(
                      image: _coverImage,
                      onPick: _pickImage,
                    ),
                    const SizedBox(height: 32),
                    AuthTextField(
                      label: 'Project Title',
                      hint: 'e.g. StartupConnect Platform',
                      prefixIcon: Icons.rocket_launch_outlined,
                      controller: _titleController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Title is required';
                        if (val.length > 50) return 'Max 50 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Project Description',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: 'Describe your vision, goals, and what you are looking for...',
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Description is required';
                        if (val.length < 50) return 'Please write at least 50 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      label: 'Maximum Team Size',
                      hint: 'e.g. 5',
                      prefixIcon: Icons.group_outlined,
                      controller: _maxTeamSizeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val == null || val.isEmpty) return 'Required';
                        final size = int.tryParse(val);
                        if (size == null || size < 2 || size > 20) return 'Must be between 2 and 20';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text('Required Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    SkillsChipSection(
                      skills: skillModels,
                      isEditing: true,
                      onRemove: _removeSkill,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _skillController,
                            decoration: const InputDecoration(
                              hintText: 'Add a skill (e.g. Flutter)',
                              prefixIcon: Icon(Icons.star_outline, size: 20),
                            ),
                            onFieldSubmitted: (_) => _addSkill(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 32),
                          onPressed: _addSkill,
                        )
                      ],
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(isEdit ? 'Save Changes' : 'Create Project'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

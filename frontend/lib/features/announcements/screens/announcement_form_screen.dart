import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../models/announcement_model.dart';
import '../providers/announcement_mutation_provider.dart';

class AnnouncementFormScreen extends ConsumerStatefulWidget {
  final String projectId;
  
  const AnnouncementFormScreen({super.key, required this.projectId});

  @override
  ConsumerState<AnnouncementFormScreen> createState() => _AnnouncementFormScreenState();
}

class _AnnouncementFormScreenState extends ConsumerState<AnnouncementFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isImportant = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final announcement = AnnouncementModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        projectId: widget.projectId,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        authorName: 'Current User', // Mocked user context
        createdAt: DateTime.now(),
        isImportant: _isImportant,
      );

      final success = await ref.read(announcementMutationProvider.notifier).createAnnouncement(announcement);
      if (success && mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Announcement broadcasted!'), backgroundColor: AppColors.success),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mutationState = ref.watch(announcementMutationProvider);
    final isLoading = mutationState is AsyncLoading;

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: const Text('New Announcement'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : _submit,
            child: isLoading
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Publish', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'e.g. Weekly All-Hands Meeting',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: 'What do you want to share with the team?',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (v) => v == null || v.isEmpty ? 'Content is required' : null,
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Mark as Important', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('This will highlight the announcement in red for all members.'),
                value: _isImportant,
                activeColor: AppColors.error,
                onChanged: (val) => setState(() => _isImportant = val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

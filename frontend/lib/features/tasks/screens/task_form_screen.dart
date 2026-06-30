import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../models/task_model.dart';
import '../providers/task_mutation_provider.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  final String projectId;
  
  const TaskFormScreen({super.key, required this.projectId});

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final task = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        projectId: widget.projectId,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        status: TaskStatus.TODO,
        createdAt: DateTime.now(),
        dueDate: _selectedDate,
      );

      final success = await ref.read(taskMutationProvider.notifier).createTask(task);
      if (success && mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task created successfully!'), backgroundColor: AppColors.success),
        );
      }
    }
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mutationState = ref.watch(taskMutationProvider);
    final isLoading = mutationState is AsyncLoading;

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
        title: const Text('Create Task'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : _submit,
            child: isLoading
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  labelText: 'Task Title',
                  hintText: 'e.g. Design Login Flow',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Add details, requirements, etc.',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (v) => v == null || v.isEmpty ? 'Description is required' : null,
              ),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today, color: AppColors.primary),
                title: Text(_selectedDate == null ? 'Set Due Date' : DateFormat('MMM d, yyyy').format(_selectedDate!)),
                trailing: _selectedDate != null
                    ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _selectedDate = null))
                    : const Icon(Icons.chevron_right),
                onTap: _pickDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

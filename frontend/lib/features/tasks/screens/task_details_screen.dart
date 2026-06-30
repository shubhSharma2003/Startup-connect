import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../models/task_model.dart';
import '../providers/task_mutation_provider.dart';
import '../widgets/task_status_badge.dart';

class TaskDetailsScreen extends ConsumerWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  void _showStatusBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _StatusBottomSheet(task: task),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Task Details'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskStatusBadge(status: task.status),
                if (task.dueDate != null)
                  Text(
                    'Due ${DateFormat('MMM d, yyyy').format(task.dueDate!)}',
                    style: TextStyle(
                      color: task.dueDate!.isBefore(DateTime.now()) && task.status != TaskStatus.DONE
                          ? AppColors.error
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 32),
            if (task.assigneeName != null) ...[
              const Text('Assignee', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.person, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Text(task.assigneeName!, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ElevatedButton(
            onPressed: () => _showStatusBottomSheet(context, ref),
            child: const Text('Update Status'),
          ),
        ),
      ),
    );
  }
}

class _StatusBottomSheet extends ConsumerWidget {
  final TaskModel task;

  const _StatusBottomSheet({required this.task});

  void _updateStatus(BuildContext context, WidgetRef ref, TaskStatus newStatus) async {
    final success = await ref.read(taskMutationProvider.notifier).updateTaskStatus(task.projectId, task.id, newStatus);
    if (success && context.mounted) {
      Navigator.pop(context);
      context.pop(); // Pop back to tasks screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status updated successfully'), backgroundColor: AppColors.success),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutationState = ref.watch(taskMutationProvider);
    final isLoading = mutationState is AsyncLoading;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          const Text('Move Task to...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (isLoading)
            const Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())
          else ...[
            _buildStatusTile(context, ref, TaskStatus.TODO, 'To Do', Colors.grey),
            _buildStatusTile(context, ref, TaskStatus.IN_PROGRESS, 'In Progress', Colors.orange),
            _buildStatusTile(context, ref, TaskStatus.DONE, 'Done', AppColors.success),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusTile(BuildContext context, WidgetRef ref, TaskStatus status, String title, Color color) {
    final isSelected = task.status == status;
    return ListTile(
      leading: Icon(Icons.circle, color: color, size: 16),
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: isSelected ? null : () => _updateStatus(context, ref, status),
    );
  }
}

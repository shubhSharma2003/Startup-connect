import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/tasks_provider.dart';
import '../models/task_model.dart';
import '../widgets/task_card.dart';

class TasksScreen extends ConsumerWidget {
  final String projectId;

  const TasksScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(tasksProvider(projectId));

    return DefaultTabController(
      length: 3,
      child: BaseScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Project Tasks'),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'To Do'),
              Tab(text: 'In Progress'),
              Tab(text: 'Done'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push('/team/$projectId/tasks/new'),
          icon: const Icon(Icons.add),
          label: const Text('New Task'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: tasksState.when(
          data: (tasks) {
            final todoTasks = tasks.where((t) => t.status == TaskStatus.TODO).toList();
            final inProgressTasks = tasks.where((t) => t.status == TaskStatus.IN_PROGRESS).toList();
            final doneTasks = tasks.where((t) => t.status == TaskStatus.DONE).toList();

            Future<void> onRefresh() async {
              await ref.read(tasksProvider(projectId).notifier).refresh();
            }

            return TabBarView(
              children: [
                _buildTaskList(todoTasks, onRefresh),
                _buildTaskList(inProgressTasks, onRefresh),
                _buildTaskList(doneTasks, onRefresh),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                const SizedBox(height: 16),
                const Text('Failed to load tasks'),
                ElevatedButton(
                  onPressed: () => ref.read(tasksProvider(projectId).notifier).refresh(),
                  child: const Text('Retry'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList(List<TaskModel> tasks, Future<void> Function() onRefresh) {
    if (tasks.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: 400,
            child: Center(
              child: Text('No tasks in this column.', style: TextStyle(color: AppColors.textSecondary)),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: tasks[index]);
        },
      ),
    );
  }
}

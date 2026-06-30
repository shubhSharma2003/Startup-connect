import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';
import 'tasks_provider.dart';

final taskMutationProvider = AsyncNotifierProvider<TaskMutationNotifier, void>(() {
  return TaskMutationNotifier();
});

class TaskMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> createTask(TaskModel task) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(taskRepositoryProvider);
      await repo.createTask(task);
      
      ref.invalidate(tasksProvider(task.projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> updateTaskStatus(String projectId, String taskId, TaskStatus newStatus) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(taskRepositoryProvider);
      await repo.updateTaskStatus(projectId, taskId, newStatus);
      
      ref.invalidate(tasksProvider(projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

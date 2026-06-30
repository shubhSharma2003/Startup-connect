import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../repositories/task_repository.dart';

final tasksProvider = AsyncNotifierProviderFamily<TasksNotifier, List<TaskModel>, String>(
  TasksNotifier.new,
);

class TasksNotifier extends FamilyAsyncNotifier<List<TaskModel>, String> {
  @override
  Future<List<TaskModel>> build(String arg) async {
    final repo = ref.watch(taskRepositoryProvider);
    return repo.fetchTasks(arg);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

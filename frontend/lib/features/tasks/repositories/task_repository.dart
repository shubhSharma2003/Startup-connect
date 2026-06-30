import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/task_model.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(dioClientProvider).dio);
});

class TaskRepository {
  final Dio _dio;

  TaskRepository(this._dio);

  Future<List<TaskModel>> fetchTasks(String projectId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      
      return [
        TaskModel(
          id: 'task_1',
          projectId: projectId,
          title: 'Design Landing Page',
          description: 'Create high fidelity mockups for the new landing page following the Material 3 guidelines.',
          status: TaskStatus.DONE,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          dueDate: DateTime.now().add(const Duration(days: 2)),
          assigneeName: 'Charlie Brown',
        ),
        TaskModel(
          id: 'task_2',
          projectId: projectId,
          title: 'Implement Authentication UI',
          description: 'Build the login and registration screens with proper validation and error states.',
          status: TaskStatus.IN_PROGRESS,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          dueDate: DateTime.now().add(const Duration(days: 5)),
          assigneeName: 'Alice Smith',
        ),
        TaskModel(
          id: 'task_3',
          projectId: projectId,
          title: 'Setup CI/CD Pipeline',
          description: 'Configure GitHub Actions for automated testing and building of the Flutter app.',
          status: TaskStatus.TODO,
          createdAt: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 10)),
          assigneeName: 'Bob Jones',
        ),
      ];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> createTask(TaskModel task) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.post('/projects/${task.projectId}/tasks', data: task.toJson());
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> updateTaskStatus(String projectId, String taskId, TaskStatus newStatus) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.put('/projects/$projectId/tasks/$taskId/status', data: {'status': newStatus.name});
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      return Exception(message);
    }
    return Exception(e.message ?? 'Network error occurred');
  }
}

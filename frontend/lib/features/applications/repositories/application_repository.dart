import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/application_model.dart';

final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  return ApplicationRepository(ref.watch(dioClientProvider).dio);
});

class ApplicationRepository {
  final Dio _dio;

  ApplicationRepository(this._dio);

  Future<List<ApplicationModel>> fetchMyApplications() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      
      // Mock Response Data
      return [
        ApplicationModel(
          id: 'app_1',
          projectId: 'proj_1',
          projectTitle: 'NextGen AI Platform',
          projectOwnerName: 'Alice Smith',
          status: ApplicationStatus.PENDING,
          appliedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        ApplicationModel(
          id: 'app_2',
          projectId: 'proj_2',
          projectTitle: 'HealthTech Connect',
          projectOwnerName: 'Bob Jones',
          status: ApplicationStatus.ACCEPTED,
          appliedAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        ApplicationModel(
          id: 'app_3',
          projectId: 'proj_3',
          projectTitle: 'FinTech Revolution',
          projectOwnerName: 'Charlie Brown',
          status: ApplicationStatus.REJECTED,
          appliedAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
      ];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> withdrawApplication(String applicationId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.delete('/applications/$applicationId');
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

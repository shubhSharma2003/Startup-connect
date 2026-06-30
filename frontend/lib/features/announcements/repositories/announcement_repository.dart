import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/announcement_model.dart';

final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  return AnnouncementRepository(ref.watch(dioClientProvider).dio);
});

class AnnouncementRepository {
  final Dio _dio;

  AnnouncementRepository(this._dio);

  Future<List<AnnouncementModel>> fetchAnnouncements(String projectId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      
      return [
        AnnouncementModel(
          id: 'ann_1',
          projectId: projectId,
          title: 'Welcome to the new Workspace!',
          content: 'We have officially launched our new collaborative workspace. Please make sure to check the task board and claim any pending tasks. Let\'s build something great!',
          authorName: 'Alice Smith',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          isImportant: true,
        ),
        AnnouncementModel(
          id: 'ann_2',
          projectId: projectId,
          title: 'Design System Update',
          content: 'The new Material 3 design system has been finalized. Please ensure all new screens adhere to the color palette outlined in Figma.',
          authorName: 'Charlie Brown',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          isImportant: false,
        ),
      ];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> createAnnouncement(AnnouncementModel announcement) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.post('/projects/${announcement.projectId}/announcements', data: announcement.toJson());
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

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/file_model.dart';

final fileRepositoryProvider = Provider<FileRepository>((ref) {
  return FileRepository(ref.watch(dioClientProvider).dio);
});

class FileRepository {
  final Dio _dio;

  FileRepository(this._dio);

  Future<List<FileModel>> fetchFiles(String projectId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      
      return [
        FileModel(
          id: 'file_1',
          projectId: projectId,
          name: 'Pitch_Deck_v2',
          extension: 'pdf',
          sizeInBytes: 2500000, // 2.5 MB
          uploadedBy: 'Alice Smith',
          uploadedAt: DateTime.now().subtract(const Duration(days: 2)),
          url: 'https://mock.com/pitch_deck.pdf',
        ),
        FileModel(
          id: 'file_2',
          projectId: projectId,
          name: 'Q3_Financials',
          extension: 'xlsx',
          sizeInBytes: 850000, // 850 KB
          uploadedBy: 'Charlie Brown',
          uploadedAt: DateTime.now().subtract(const Duration(days: 5)),
          url: 'https://mock.com/financials.xlsx',
        ),
        FileModel(
          id: 'file_3',
          projectId: projectId,
          name: 'Landing_Page_Hero',
          extension: 'png',
          sizeInBytes: 4200000, // 4.2 MB
          uploadedBy: 'Design Lead',
          uploadedAt: DateTime.now().subtract(const Duration(hours: 4)),
          url: 'https://mock.com/hero.png',
        ),
        FileModel(
          id: 'file_4',
          projectId: projectId,
          name: 'Product_Requirements',
          extension: 'docx',
          sizeInBytes: 150000, // 150 KB
          uploadedBy: 'Alice Smith',
          uploadedAt: DateTime.now().subtract(const Duration(hours: 1)),
          url: 'https://mock.com/prd.docx',
        ),
      ];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> uploadFile(FileModel file, String localPath) async {
    try {
      // Mocking a slow upload process
      await Future.delayed(const Duration(seconds: 2)); 
      // await _dio.post('/projects/${file.projectId}/files', data: formData);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteFile(String projectId, String fileId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // await _dio.delete('/projects/$projectId/files/$fileId');
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

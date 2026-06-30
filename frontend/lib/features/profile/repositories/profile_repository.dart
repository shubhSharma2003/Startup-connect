import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(dioClientProvider).dio);
});

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  Future<ProfileModel> getProfile() async {
    try {
      // Mock delay to simulate network
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock Response since backend is not fully connected for this endpoint yet
      // final response = await _dio.get('/profile');
      
      return const ProfileModel(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@startupconnect.com',
        role: 'STUDENT',
        headline: 'Flutter Developer & AI Enthusiast',
        bio: 'I am a passionate software engineering student looking to join an exciting startup. I specialize in building responsive cross-platform applications using Flutter and connecting them to robust backend microservices.',
        avatarUrl: null,
        projectsCount: 4,
        teamsCount: 2,
        connectionsCount: 156,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ProfileModel> updateProfile(ProfileModel updatedProfile) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      // final response = await _dio.put('/profile', data: updatedProfile.toJson());
      return updatedProfile; // Mock returning updated data
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<String> uploadAvatar(XFile file) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // final formData = FormData.fromMap({
      //   'file': await MultipartFile.fromFile(file.path, filename: file.name),
      // });
      // final response = await _dio.post('/profile/upload-avatar', data: formData);
      return 'https://example.com/avatar_uploaded.png';
    } catch (e) {
      throw Exception('Failed to upload avatar');
    }
  }

  Future<String> uploadResume(PlatformFile file) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // final formData = FormData.fromMap({
      //   'file': await MultipartFile.fromFile(file.path!, filename: file.name),
      // });
      // final response = await _dio.post('/profile/upload-resume', data: formData);
      return 'https://example.com/resume_uploaded.pdf';
    } catch (e) {
      throw Exception('Failed to upload resume');
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

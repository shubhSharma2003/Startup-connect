import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioClientProvider).dio);
});

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      
      // Backend returns: { "success": true, "data": { "token": "...", "user": {...} } }
      if (response.data['success'] == true) {
        return AuthResponse.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: request.toJson(),
      );
      
      if (response.data['success'] == true) {
        return AuthResponse.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
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

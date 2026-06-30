import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/review_model.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(ref.watch(dioClientProvider).dio);
});

class ReviewRepository {
  final Dio _dio;

  ReviewRepository(this._dio);

  Future<List<ReviewModel>> fetchReviewsForUser(String userId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      
      return [
        ReviewModel(
          id: 'rev_1',
          targetUserId: userId,
          reviewerId: 'user_a',
          reviewerName: 'Alice Smith',
          rating: 5.0,
          comment: 'Fantastic collaboration! Delivered high-quality code ahead of schedule.',
          createdAt: DateTime.now().subtract(const Duration(days: 14)),
        ),
        ReviewModel(
          id: 'rev_2',
          targetUserId: userId,
          reviewerId: 'user_b',
          reviewerName: 'Charlie Brown',
          rating: 4.0,
          comment: 'Great communication and solid technical skills. Would definitely work together again.',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
      ];
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> submitReview(ReviewModel review) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.post('/users/${review.targetUserId}/reviews', data: review.toJson());
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

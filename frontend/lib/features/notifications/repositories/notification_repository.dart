import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/notification_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(dioClientProvider).dio);
});

class NotificationRepository {
  final Dio _dio;
  
  // Simulated backend stream controller for real-time push notifications
  final StreamController<List<NotificationModel>> _streamController = StreamController<List<NotificationModel>>.broadcast();
  List<NotificationModel> _mockCache = [];

  NotificationRepository(this._dio) {
    _initializeMockData();
  }

  void _initializeMockData() {
    _mockCache = [
      NotificationModel(
        id: 'notif_1',
        title: 'New Task Assigned',
        body: 'You have been assigned to "Design Landing Page" in Project Phoenix.',
        type: NotificationType.taskAssigned,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationModel(
        id: 'notif_2',
        title: 'Application Accepted!',
        body: 'Your application for Frontend Developer at StartupX was accepted.',
        type: NotificationType.applicationUpdate,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_3',
        title: 'Role Update',
        body: 'Alice Smith has promoted you to Admin in "Project Phoenix".',
        type: NotificationType.roleChanged,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
    _streamController.add(_mockCache);
  }

  /// Watch real-time notifications
  Stream<List<NotificationModel>> watchNotifications() {
    // Re-emit current cache instantly on listen
    Future.microtask(() => _streamController.add(_mockCache));
    return _streamController.stream;
  }

  Future<void> markAsRead(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300)); // Mock network delay
      // await _dio.put('/notifications/$id/read');
      
      final index = _mockCache.indexWhere((n) => n.id == id);
      if (index != -1) {
        _mockCache[index] = _mockCache[index].copyWith(isRead: true);
        _streamController.add(_mockCache); // Push real-time update
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // await _dio.put('/notifications/read-all');
      
      _mockCache = _mockCache.map((n) => n.copyWith(isRead: true)).toList();
      _streamController.add(_mockCache);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // await _dio.delete('/notifications/$id');
      
      _mockCache.removeWhere((n) => n.id == id);
      _streamController.add(_mockCache);
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

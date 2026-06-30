import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/notification_repository.dart';

final notificationMutationProvider = AsyncNotifierProvider<NotificationMutationNotifier, void>(() {
  return NotificationMutationNotifier();
});

class NotificationMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> markAsRead(String id) async {
    try {
      final repo = ref.read(notificationRepositoryProvider);
      await repo.markAsRead(id);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> markAllAsRead() async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(notificationRepositoryProvider);
      await repo.markAllAsRead();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      final repo = ref.read(notificationRepositoryProvider);
      await repo.deleteNotification(id);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

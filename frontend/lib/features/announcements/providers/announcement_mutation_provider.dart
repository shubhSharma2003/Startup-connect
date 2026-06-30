import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/announcement_model.dart';
import '../repositories/announcement_repository.dart';
import 'announcements_provider.dart';

final announcementMutationProvider = AsyncNotifierProvider<AnnouncementMutationNotifier, void>(() {
  return AnnouncementMutationNotifier();
});

class AnnouncementMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> createAnnouncement(AnnouncementModel announcement) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(announcementRepositoryProvider);
      await repo.createAnnouncement(announcement);
      
      ref.invalidate(announcementsProvider(announcement.projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

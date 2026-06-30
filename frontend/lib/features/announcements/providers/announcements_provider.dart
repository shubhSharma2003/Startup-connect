import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/announcement_model.dart';
import '../repositories/announcement_repository.dart';

final announcementsProvider = AsyncNotifierProviderFamily<AnnouncementsNotifier, List<AnnouncementModel>, String>(
  AnnouncementsNotifier.new,
);

class AnnouncementsNotifier extends FamilyAsyncNotifier<List<AnnouncementModel>, String> {
  @override
  Future<List<AnnouncementModel>> build(String arg) async {
    final repo = ref.watch(announcementRepositoryProvider);
    final announcements = await repo.fetchAnnouncements(arg);
    // Sort chronologically (newest first)
    announcements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return announcements;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

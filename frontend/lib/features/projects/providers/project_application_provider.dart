import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/project_repository.dart';
import 'project_details_provider.dart';
import '../models/project_details_model.dart';

final projectApplicationProvider = AsyncNotifierProvider<ProjectApplicationNotifier, void>(() {
  return ProjectApplicationNotifier();
});

class ProjectApplicationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> apply(String projectId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(projectRepositoryProvider);
      await repo.applyToProject(projectId);
      
      // Update the local cache to show pending status
      final currentDetails = ref.read(projectDetailsProvider(projectId)).value;
      if (currentDetails != null) {
        // We override the provider state with the new status
        // A hacky but effective way for local optimistic update in a family provider:
        // Or we just invalidate the details provider to force a network refresh.
        // Let's just invalidate it to get fresh data:
        ref.invalidate(projectDetailsProvider(projectId));
      }

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

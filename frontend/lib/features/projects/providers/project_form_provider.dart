import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/project_repository.dart';
import 'projects_provider.dart';
import 'project_details_provider.dart';

final projectFormProvider = AsyncNotifierProvider<ProjectFormNotifier, void>(() {
  return ProjectFormNotifier();
});

class ProjectFormNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submitForm({String? projectId, required Map<String, dynamic> data}) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(projectRepositoryProvider);
      
      if (projectId == null) {
        // Create Mode
        await repo.createProject(data);
        // Invalidate list to show new project
        ref.invalidate(projectsProvider);
      } else {
        // Edit Mode
        await repo.updateProject(projectId, data);
        // Invalidate list and the specific details view
        ref.invalidate(projectsProvider);
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

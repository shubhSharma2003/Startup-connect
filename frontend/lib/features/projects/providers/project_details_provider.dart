import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_details_model.dart';
import '../repositories/project_repository.dart';

final projectDetailsProvider = AsyncNotifierProviderFamily<ProjectDetailsNotifier, ProjectDetailsModel, String>(
  ProjectDetailsNotifier.new,
);

class ProjectDetailsNotifier extends FamilyAsyncNotifier<ProjectDetailsModel, String> {
  @override
  Future<ProjectDetailsModel> build(String arg) async {
    final repo = ref.watch(projectRepositoryProvider);
    return repo.getProjectById(arg);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

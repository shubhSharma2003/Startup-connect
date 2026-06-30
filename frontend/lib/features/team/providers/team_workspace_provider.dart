import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team_workspace_model.dart';
import '../repositories/team_repository.dart';

final teamWorkspaceProvider = AsyncNotifierProviderFamily<TeamWorkspaceNotifier, TeamWorkspaceModel, String>(
  TeamWorkspaceNotifier.new,
);

class TeamWorkspaceNotifier extends FamilyAsyncNotifier<TeamWorkspaceModel, String> {
  @override
  Future<TeamWorkspaceModel> build(String arg) async {
    final repo = ref.watch(teamRepositoryProvider);
    return repo.fetchWorkspace(arg);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

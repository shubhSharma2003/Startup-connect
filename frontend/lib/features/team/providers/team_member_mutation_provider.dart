import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/team_repository.dart';
import 'team_workspace_provider.dart';
import '../models/team_member_extended_model.dart';

final teamMemberMutationProvider = AsyncNotifierProvider<TeamMemberMutationNotifier, void>(() {
  return TeamMemberMutationNotifier();
});

class TeamMemberMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> removeMember(String projectId, String memberId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(teamRepositoryProvider);
      await repo.removeMember(projectId, memberId);
      
      // Successfully removed, invalidate the workspace to fetch updated member list
      ref.invalidate(teamWorkspaceProvider(projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> updateRole(String projectId, String memberId, TeamRole newRole) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(teamRepositoryProvider);
      await repo.updateRole(projectId, memberId, newRole);
      
      // Successfully updated, invalidate the workspace to fetch updated member list
      ref.invalidate(teamWorkspaceProvider(projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

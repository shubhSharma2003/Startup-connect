import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/team_workspace_model.dart';
import '../models/team_member_extended_model.dart';

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepository(ref.watch(dioClientProvider).dio);
});

class TeamRepository {
  final Dio _dio;

  TeamRepository(this._dio);

  Future<TeamWorkspaceModel> fetchWorkspace(String projectId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      
      return TeamWorkspaceModel(
        projectId: projectId,
        projectTitle: 'Mock Project Workspace',
        activeMembers: 3,
        pendingTasks: 12,
        upcomingDeadlines: 2,
        completedMilestones: 5,
        members: [
          TeamMemberExtendedModel(
            id: 'tm_1',
            name: 'Alice Smith',
            title: 'Founder & CEO',
            role: TeamRole.OWNER,
            joinedAt: DateTime.now().subtract(const Duration(days: 60)),
          ),
          TeamMemberExtendedModel(
            id: 'tm_2',
            name: 'Bob Jones',
            title: 'Backend Lead',
            role: TeamRole.ADMIN,
            joinedAt: DateTime.now().subtract(const Duration(days: 30)),
          ),
          TeamMemberExtendedModel(
            id: 'tm_3',
            name: 'Charlie Brown',
            title: 'UI Designer',
            role: TeamRole.MEMBER,
            joinedAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
        ],
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> removeMember(String projectId, String memberId) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.delete('/projects/$projectId/members/$memberId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> updateRole(String projectId, String memberId, TeamRole newRole) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network
      // await _dio.put('/projects/$projectId/members/$memberId/role', data: {'role': newRole.name});
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

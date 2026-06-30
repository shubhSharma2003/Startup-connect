import 'package:freezed_annotation/freezed_annotation.dart';
import 'team_member_extended_model.dart';

part 'team_workspace_model.freezed.dart';
part 'team_workspace_model.g.dart';

@freezed
class TeamWorkspaceModel with _$TeamWorkspaceModel {
  const factory TeamWorkspaceModel({
    required String projectId,
    required String projectTitle,
    @Default(0) int activeMembers,
    @Default(0) int pendingTasks,
    @Default(0) int upcomingDeadlines,
    @Default(0) int completedMilestones,
    @Default([]) List<TeamMemberExtendedModel> members,
  }) = _TeamWorkspaceModel;

  factory TeamWorkspaceModel.fromJson(Map<String, dynamic> json) => _$TeamWorkspaceModelFromJson(json);
}

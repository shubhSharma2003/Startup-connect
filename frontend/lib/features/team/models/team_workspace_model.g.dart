// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_workspace_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamWorkspaceModelImpl _$$TeamWorkspaceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamWorkspaceModelImpl(
      projectId: json['projectId'] as String,
      projectTitle: json['projectTitle'] as String,
      activeMembers: (json['activeMembers'] as num?)?.toInt() ?? 0,
      pendingTasks: (json['pendingTasks'] as num?)?.toInt() ?? 0,
      upcomingDeadlines: (json['upcomingDeadlines'] as num?)?.toInt() ?? 0,
      completedMilestones: (json['completedMilestones'] as num?)?.toInt() ?? 0,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) =>
                  TeamMemberExtendedModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TeamWorkspaceModelImplToJson(
        _$TeamWorkspaceModelImpl instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'projectTitle': instance.projectTitle,
      'activeMembers': instance.activeMembers,
      'pendingTasks': instance.pendingTasks,
      'upcomingDeadlines': instance.upcomingDeadlines,
      'completedMilestones': instance.completedMilestones,
      'members': instance.members,
    };

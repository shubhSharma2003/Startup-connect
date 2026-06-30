// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      assigneeId: json['assigneeId'] as String?,
      assigneeName: json['assigneeName'] as String?,
      assigneeAvatar: json['assigneeAvatar'] as String?,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'title': instance.title,
      'description': instance.description,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'assigneeId': instance.assigneeId,
      'assigneeName': instance.assigneeName,
      'assigneeAvatar': instance.assigneeAvatar,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.TODO: 'TODO',
  TaskStatus.IN_PROGRESS: 'IN_PROGRESS',
  TaskStatus.DONE: 'DONE',
};

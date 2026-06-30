// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      isRead: json['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      relatedId: json['relatedId'] as String?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'relatedId': instance.relatedId,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.applicationUpdate: 'applicationUpdate',
  NotificationType.taskAssigned: 'taskAssigned',
  NotificationType.roleChanged: 'roleChanged',
  NotificationType.general: 'general',
};

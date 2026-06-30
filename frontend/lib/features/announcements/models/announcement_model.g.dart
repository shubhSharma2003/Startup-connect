// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnnouncementModelImpl _$$AnnouncementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AnnouncementModelImpl(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isImportant: json['isImportant'] as bool? ?? false,
    );

Map<String, dynamic> _$$AnnouncementModelImplToJson(
        _$AnnouncementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'title': instance.title,
      'content': instance.content,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'createdAt': instance.createdAt.toIso8601String(),
      'isImportant': instance.isImportant,
    };

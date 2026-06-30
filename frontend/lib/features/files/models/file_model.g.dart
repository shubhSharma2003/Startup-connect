// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FileModelImpl _$$FileModelImplFromJson(Map<String, dynamic> json) =>
    _$FileModelImpl(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      name: json['name'] as String,
      extension: json['extension'] as String,
      sizeInBytes: (json['sizeInBytes'] as num).toInt(),
      uploadedBy: json['uploadedBy'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$FileModelImplToJson(_$FileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'name': instance.name,
      'extension': instance.extension,
      'sizeInBytes': instance.sizeInBytes,
      'uploadedBy': instance.uploadedBy,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'url': instance.url,
    };

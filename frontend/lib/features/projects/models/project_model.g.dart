// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      shortDescription: json['shortDescription'] as String,
      ownerName: json['ownerName'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      teamSize: (json['teamSize'] as num?)?.toInt() ?? 0,
      maxTeamSize: (json['maxTeamSize'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'shortDescription': instance.shortDescription,
      'ownerName': instance.ownerName,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'requiredSkills': instance.requiredSkills,
      'teamSize': instance.teamSize,
      'maxTeamSize': instance.maxTeamSize,
    };

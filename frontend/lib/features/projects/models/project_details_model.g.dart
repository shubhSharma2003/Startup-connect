// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectDetailsModelImpl _$$ProjectDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProjectDetailsModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      fullDescription: json['fullDescription'] as String,
      ownerName: json['ownerName'] as String,
      ownerId: json['ownerId'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      teamMembers: (json['teamMembers'] as List<dynamic>?)
              ?.map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      maxTeamSize: (json['maxTeamSize'] as num?)?.toInt() ?? 0,
      applicationStatus: $enumDecodeNullable(
              _$ApplicationStatusEnumMap, json['applicationStatus']) ??
          ApplicationStatus.NONE,
    );

Map<String, dynamic> _$$ProjectDetailsModelImplToJson(
        _$ProjectDetailsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'fullDescription': instance.fullDescription,
      'ownerName': instance.ownerName,
      'ownerId': instance.ownerId,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'requiredSkills': instance.requiredSkills,
      'teamMembers': instance.teamMembers,
      'maxTeamSize': instance.maxTeamSize,
      'applicationStatus':
          _$ApplicationStatusEnumMap[instance.applicationStatus]!,
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.NONE: 'NONE',
  ApplicationStatus.PENDING: 'PENDING',
  ApplicationStatus.ACCEPTED: 'ACCEPTED',
  ApplicationStatus.REJECTED: 'REJECTED',
};

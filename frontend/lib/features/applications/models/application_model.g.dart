// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationModelImpl _$$ApplicationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationModelImpl(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      projectTitle: json['projectTitle'] as String,
      projectOwnerName: json['projectOwnerName'] as String,
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
      appliedAt: DateTime.parse(json['appliedAt'] as String),
      customMessage: json['customMessage'] as String?,
    );

Map<String, dynamic> _$$ApplicationModelImplToJson(
        _$ApplicationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'projectTitle': instance.projectTitle,
      'projectOwnerName': instance.projectOwnerName,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'appliedAt': instance.appliedAt.toIso8601String(),
      'customMessage': instance.customMessage,
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.PENDING: 'PENDING',
  ApplicationStatus.ACCEPTED: 'ACCEPTED',
  ApplicationStatus.REJECTED: 'REJECTED',
};

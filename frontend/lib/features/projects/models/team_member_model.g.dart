// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamMemberModelImpl _$$TeamMemberModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamMemberModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$$TeamMemberModelImplToJson(
        _$TeamMemberModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'avatarUrl': instance.avatarUrl,
    };

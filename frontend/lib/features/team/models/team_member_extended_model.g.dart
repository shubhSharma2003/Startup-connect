// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_member_extended_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamMemberExtendedModelImpl _$$TeamMemberExtendedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamMemberExtendedModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      role: $enumDecode(_$TeamRoleEnumMap, json['role']),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$$TeamMemberExtendedModelImplToJson(
        _$TeamMemberExtendedModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'role': _$TeamRoleEnumMap[instance.role]!,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'avatarUrl': instance.avatarUrl,
    };

const _$TeamRoleEnumMap = {
  TeamRole.OWNER: 'OWNER',
  TeamRole.ADMIN: 'ADMIN',
  TeamRole.MEMBER: 'MEMBER',
  TeamRole.VIEWER: 'VIEWER',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      headline: json['headline'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      resumeUrl: json['resumeUrl'] as String?,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      portfolioLinks: (json['portfolioLinks'] as List<dynamic>?)
              ?.map((e) => PortfolioLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      projectsCount: (json['projectsCount'] as num?)?.toInt() ?? 0,
      teamsCount: (json['teamsCount'] as num?)?.toInt() ?? 0,
      connectionsCount: (json['connectionsCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'headline': instance.headline,
      'bio': instance.bio,
      'avatarUrl': instance.avatarUrl,
      'resumeUrl': instance.resumeUrl,
      'skills': instance.skills,
      'portfolioLinks': instance.portfolioLinks,
      'projectsCount': instance.projectsCount,
      'teamsCount': instance.teamsCount,
      'connectionsCount': instance.connectionsCount,
    };

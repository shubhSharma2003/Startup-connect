// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      targetUserId: json['targetUserId'] as String,
      reviewerId: json['reviewerId'] as String,
      reviewerName: json['reviewerName'] as String,
      reviewerAvatar: json['reviewerAvatar'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'targetUserId': instance.targetUserId,
      'reviewerId': instance.reviewerId,
      'reviewerName': instance.reviewerName,
      'reviewerAvatar': instance.reviewerAvatar,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };

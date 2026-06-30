import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_member_extended_model.freezed.dart';
part 'team_member_extended_model.g.dart';

enum TeamRole { OWNER, ADMIN, MEMBER, VIEWER }

@freezed
class TeamMemberExtendedModel with _$TeamMemberExtendedModel {
  const factory TeamMemberExtendedModel({
    required String id,
    required String name,
    required String title,
    required TeamRole role,
    required DateTime joinedAt,
    String? avatarUrl,
  }) = _TeamMemberExtendedModel;

  factory TeamMemberExtendedModel.fromJson(Map<String, dynamic> json) => _$TeamMemberExtendedModelFromJson(json);
}

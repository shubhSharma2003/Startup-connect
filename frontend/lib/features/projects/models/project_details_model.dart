import 'package:freezed_annotation/freezed_annotation.dart';
import 'team_member_model.dart';

part 'project_details_model.freezed.dart';
part 'project_details_model.g.dart';

enum ApplicationStatus { NONE, PENDING, ACCEPTED, REJECTED }

@freezed
class ProjectDetailsModel with _$ProjectDetailsModel {
  const factory ProjectDetailsModel({
    required String id,
    required String title,
    required String fullDescription,
    required String ownerName,
    required String ownerId,
    required String status,
    required DateTime createdAt,
    @Default([]) List<String> requiredSkills,
    @Default([]) List<TeamMemberModel> teamMembers,
    @Default(0) int maxTeamSize,
    @Default(ApplicationStatus.NONE) ApplicationStatus applicationStatus,
  }) = _ProjectDetailsModel;

  factory ProjectDetailsModel.fromJson(Map<String, dynamic> json) => _$ProjectDetailsModelFromJson(json);
}

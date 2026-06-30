import 'package:freezed_annotation/freezed_annotation.dart';
import 'skill_model.dart';
import 'portfolio_link.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    String? headline,
    String? bio,
    String? avatarUrl,
    String? resumeUrl,
    @Default([]) List<SkillModel> skills,
    @Default([]) List<PortfolioLink> portfolioLinks,
    @Default(0) int projectsCount,
    @Default(0) int teamsCount,
    @Default(0) int connectionsCount,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

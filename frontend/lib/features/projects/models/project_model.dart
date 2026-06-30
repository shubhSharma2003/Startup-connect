import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String title,
    required String shortDescription,
    required String ownerName,
    required String status,
    required DateTime createdAt,
    @Default([]) List<String> requiredSkills,
    @Default(0) int teamSize,
    @Default(0) int maxTeamSize,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);
}

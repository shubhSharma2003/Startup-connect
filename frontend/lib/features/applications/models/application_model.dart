import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

enum ApplicationStatus { PENDING, ACCEPTED, REJECTED }

@freezed
class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    required String id,
    required String projectId,
    required String projectTitle,
    required String projectOwnerName,
    required ApplicationStatus status,
    required DateTime appliedAt,
    String? customMessage,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);
}

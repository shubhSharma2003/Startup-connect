import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_filter_model.freezed.dart';

@freezed
class ProjectFilterModel with _$ProjectFilterModel {
  const factory ProjectFilterModel({
    @Default('') String searchQuery,
    String? status, // 'OPEN', 'CLOSED', etc.
  }) = _ProjectFilterModel;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'project_form_model.freezed.dart';

@freezed
class ProjectFormModel with _$ProjectFormModel {
  const factory ProjectFormModel({
    @Default('') String title,
    @Default('') String description,
    @Default([]) List<String> requiredSkills,
    @Default(5) int maxTeamSize,
    XFile? coverImage,
  }) = _ProjectFormModel;
}

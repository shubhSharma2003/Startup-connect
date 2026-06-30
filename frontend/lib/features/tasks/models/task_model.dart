import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskStatus { TODO, IN_PROGRESS, DONE }

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String projectId,
    required String title,
    required String description,
    required TaskStatus status,
    required DateTime createdAt,
    DateTime? dueDate,
    String? assigneeId,
    String? assigneeName,
    String? assigneeAvatar,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}

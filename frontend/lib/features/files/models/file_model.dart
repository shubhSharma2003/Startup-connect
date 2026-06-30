import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_model.freezed.dart';
part 'file_model.g.dart';

@freezed
class FileModel with _$FileModel {
  const factory FileModel({
    required String id,
    required String projectId,
    required String name,
    required String extension,
    required int sizeInBytes,
    required String uploadedBy,
    required DateTime uploadedAt,
    required String url, // Mock URL for download simulation
  }) = _FileModel;

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);
}

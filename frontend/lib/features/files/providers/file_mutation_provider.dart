import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/file_model.dart';
import '../repositories/file_repository.dart';
import 'files_provider.dart';

final fileMutationProvider = AsyncNotifierProvider<FileMutationNotifier, void>(() {
  return FileMutationNotifier();
});

class FileMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> uploadFile(String projectId, String filePath, String fileName, String extension, int size) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(fileRepositoryProvider);
      
      final mockFile = FileModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        projectId: projectId,
        name: fileName,
        extension: extension,
        sizeInBytes: size,
        uploadedBy: 'Current User', // Mocked user context
        uploadedAt: DateTime.now(),
        url: 'https://mock.com/$fileName',
      );

      await repo.uploadFile(mockFile, filePath);
      
      ref.invalidate(filesProvider(projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> deleteFile(String projectId, String fileId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(fileRepositoryProvider);
      await repo.deleteFile(projectId, fileId);
      
      ref.invalidate(filesProvider(projectId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

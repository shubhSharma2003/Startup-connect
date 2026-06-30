import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/file_model.dart';
import '../repositories/file_repository.dart';

final filesProvider = AsyncNotifierProviderFamily<FilesNotifier, List<FileModel>, String>(
  FilesNotifier.new,
);

class FilesNotifier extends FamilyAsyncNotifier<List<FileModel>, String> {
  @override
  Future<List<FileModel>> build(String arg) async {
    final repo = ref.watch(fileRepositoryProvider);
    return repo.fetchFiles(arg);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

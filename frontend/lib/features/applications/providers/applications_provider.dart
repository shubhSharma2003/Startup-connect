import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/application_model.dart';
import '../repositories/application_repository.dart';

final applicationsProvider = AsyncNotifierProvider<ApplicationsNotifier, List<ApplicationModel>>(
  ApplicationsNotifier.new,
);

class ApplicationsNotifier extends AsyncNotifier<List<ApplicationModel>> {
  @override
  Future<List<ApplicationModel>> build() async {
    final repo = ref.watch(applicationRepositoryProvider);
    return repo.fetchMyApplications();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(applicationRepositoryProvider);
      final apps = await repo.fetchMyApplications();
      state = AsyncData(apps);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

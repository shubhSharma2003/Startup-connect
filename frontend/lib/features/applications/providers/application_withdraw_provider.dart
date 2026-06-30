import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/application_repository.dart';
import 'applications_provider.dart';

final applicationWithdrawProvider = AsyncNotifierProvider<ApplicationWithdrawNotifier, void>(() {
  return ApplicationWithdrawNotifier();
});

class ApplicationWithdrawNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> withdraw(String applicationId) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(applicationRepositoryProvider);
      await repo.withdrawApplication(applicationId);
      
      // Successfully withdrawn, invalidate the main list so it refreshes
      ref.invalidate(applicationsProvider);

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review_model.dart';
import '../repositories/review_repository.dart';
import 'reviews_provider.dart';

final reviewMutationProvider = AsyncNotifierProvider<ReviewMutationNotifier, void>(() {
  return ReviewMutationNotifier();
});

class ReviewMutationNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submitReview(ReviewModel review) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(reviewRepositoryProvider);
      await repo.submitReview(review);
      
      ref.invalidate(reviewsProvider(review.targetUserId));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

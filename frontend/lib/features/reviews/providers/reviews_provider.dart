import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review_model.dart';
import '../repositories/review_repository.dart';

final reviewsProvider = AsyncNotifierProviderFamily<ReviewsNotifier, List<ReviewModel>, String>(
  ReviewsNotifier.new,
);

class ReviewsNotifier extends FamilyAsyncNotifier<List<ReviewModel>, String> {
  @override
  Future<List<ReviewModel>> build(String arg) async {
    final repo = ref.watch(reviewRepositoryProvider);
    return repo.fetchReviewsForUser(arg);
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

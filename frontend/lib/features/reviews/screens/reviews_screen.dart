import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/reviews_provider.dart';
import '../widgets/review_card.dart';
import '../widgets/star_rating.dart';

class ReviewsScreen extends ConsumerWidget {
  final String userId;

  const ReviewsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsState = ref.watch(reviewsProvider(userId));

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('User Reviews'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/users/$userId/reviews/new'),
        icon: const Icon(Icons.edit),
        label: const Text('Write a Review'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: reviewsState.when(
        data: (reviews) {
          if (reviews.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref.read(reviewsProvider(userId).notifier).refresh(),
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: Center(
                    child: Text('No reviews yet.', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                ),
              ),
            );
          }

          final double averageRating = reviews.fold(0.0, (sum, item) => sum + item.rating) / reviews.length;

          return RefreshIndicator(
            onRefresh: () => ref.read(reviewsProvider(userId).notifier).refresh(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 8),
                        StarRating(rating: averageRating, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          'Based on ${reviews.length} reviews',
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ReviewCard(review: reviews[index]);
                      },
                      childCount: reviews.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              const Text('Failed to load reviews'),
              ElevatedButton(
                onPressed: () => ref.read(reviewsProvider(userId).notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

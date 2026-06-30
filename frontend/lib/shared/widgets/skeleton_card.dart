import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'custom_shimmer.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? AppColors.borderDark : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomShimmer(width: 40, height: 40, borderRadius: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomShimmer(width: double.infinity, height: 16),
                    SizedBox(height: 8),
                    CustomShimmer(width: 100, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const CustomShimmer(width: double.infinity, height: 12),
          const SizedBox(height: 8),
          const CustomShimmer(width: 200, height: 12),
        ],
      ),
    );
  }
}

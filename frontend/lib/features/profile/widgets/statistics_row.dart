import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/profile_model.dart';

class StatisticsRow extends StatelessWidget {
  final ProfileModel profile;

  const StatisticsRow({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatCard(title: 'Projects', count: profile.projectsCount.toString()),
        _StatCard(title: 'Teams', count: profile.teamsCount.toString()),
        _StatCard(title: 'Connections', count: profile.connectionsCount.toString()),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;

  const _StatCard({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

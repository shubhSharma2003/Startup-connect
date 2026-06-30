import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/constants/app_colors.dart';
import '../models/project_details_model.dart';

class ProjectInfoHeader extends StatelessWidget {
  final ProjectDetailsModel project;

  const ProjectInfoHeader({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: project.status == 'OPEN' ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                project.status,
                style: TextStyle(
                  color: project.status == 'OPEN' ? AppColors.success : AppColors.error,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              timeago.format(project.createdAt),
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          project.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.2),
              child: const Icon(Icons.person, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            Text(
              project.ownerName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.group, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              '${project.teamMembers.length}/${project.maxTeamSize} Members',
              style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(color: AppColors.border),
      ],
    );
  }
}

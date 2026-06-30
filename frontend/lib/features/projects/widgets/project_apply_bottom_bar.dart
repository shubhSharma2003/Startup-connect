import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../models/project_details_model.dart';
import '../providers/project_application_provider.dart';

class ProjectApplyBottomBar extends ConsumerWidget {
  final ProjectDetailsModel project;

  const ProjectApplyBottomBar({super.key, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applyState = ref.watch(projectApplicationProvider);
    final isLoading = applyState is AsyncLoading;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: SafeArea(
        child: _buildButton(context, isLoading, ref),
      ),
    );
  }

  Widget _buildButton(BuildContext context, bool isLoading, WidgetRef ref) {
    if (project.status != 'OPEN') {
      return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[600],
        ),
        child: const Text('Project Closed'),
      );
    }

    switch (project.applicationStatus) {
      case ApplicationStatus.NONE:
        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  final success = await ref.read(projectApplicationProvider.notifier).apply(project.id);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Application Submitted successfully!'), backgroundColor: AppColors.success),
                    );
                  }
                },
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Apply Now'),
        );
      case ApplicationStatus.PENDING:
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Colors.orange[100],
            disabledForegroundColor: Colors.orange[800],
          ),
          child: const Text('Application Pending'),
        );
      case ApplicationStatus.ACCEPTED:
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.success.withValues(alpha: 0.2),
            disabledForegroundColor: AppColors.success,
          ),
          child: const Text('Application Accepted'),
        );
      case ApplicationStatus.REJECTED:
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.error.withValues(alpha: 0.2),
            disabledForegroundColor: AppColors.error,
          ),
          child: const Text('Application Rejected'),
        );
    }
  }
}

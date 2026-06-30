import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../models/application_model.dart';
import '../providers/application_withdraw_provider.dart';

class ApplicationCard extends ConsumerWidget {
  final ApplicationModel application;

  const ApplicationCard({super.key, required this.application});

  void _confirmWithdraw(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Withdraw Application?'),
        content: const Text('Are you sure you want to withdraw your application? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(applicationWithdrawProvider.notifier).withdraw(application.id);
            },
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawState = ref.watch(applicationWithdrawProvider);
    final isLoading = withdrawState is AsyncLoading;

    Color statusColor;
    String statusText;

    switch (application.status) {
      case ApplicationStatus.PENDING:
        statusColor = Colors.orange;
        statusText = 'Pending';
        break;
      case ApplicationStatus.ACCEPTED:
        statusColor = AppColors.success;
        statusText = 'Accepted';
        break;
      case ApplicationStatus.REJECTED:
        statusColor = AppColors.error;
        statusText = 'Rejected';
        break;
    }

    return GestureDetector(
      onTap: () => context.push('/projects/${application.projectId}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    application.projectTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(application.projectOwnerName, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: AppColors.border),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Applied ${timeago.format(application.appliedAt)}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
                if (application.status == ApplicationStatus.PENDING)
                  TextButton(
                    onPressed: isLoading ? null : () => _confirmWithdraw(context, ref),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: isLoading
                        ? const SizedBox(height: 12, width: 12, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Withdraw', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

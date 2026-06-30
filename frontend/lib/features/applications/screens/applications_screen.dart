import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/applications_provider.dart';
import '../models/application_model.dart';
import '../widgets/applications_list_view.dart';
import '../widgets/application_skeleton_list.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsState = ref.watch(applicationsProvider);

    return DefaultTabController(
      length: 3,
      child: BaseScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('My Applications'),
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: applicationsState.when(
          data: (apps) {
            final pendingApps = apps.where((a) => a.status == ApplicationStatus.PENDING).toList();
            final acceptedApps = apps.where((a) => a.status == ApplicationStatus.ACCEPTED).toList();
            final rejectedApps = apps.where((a) => a.status == ApplicationStatus.REJECTED).toList();

            Future<void> onRefresh() async {
              await ref.read(applicationsProvider.notifier).refresh();
            }

            return TabBarView(
              children: [
                ApplicationsListView(applications: pendingApps, onRefresh: onRefresh),
                ApplicationsListView(applications: acceptedApps, onRefresh: onRefresh),
                ApplicationsListView(applications: rejectedApps, onRefresh: onRefresh),
              ],
            );
          },
          loading: () => const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              ApplicationSkeletonList(),
              ApplicationSkeletonList(),
              ApplicationSkeletonList(),
            ],
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                const SizedBox(height: 16),
                const Text('Failed to load applications'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(applicationsProvider.notifier).refresh(),
                  child: const Text('Retry'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

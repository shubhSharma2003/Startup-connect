import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/announcements_provider.dart';
import '../widgets/announcement_card.dart';

class AnnouncementsScreen extends ConsumerWidget {
  final String projectId;

  const AnnouncementsScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcementsState = ref.watch(announcementsProvider(projectId));

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Announcements'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/team/$projectId/announcements/new'),
        icon: const Icon(Icons.campaign),
        label: const Text('Broadcast'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: announcementsState.when(
        data: (announcements) {
          if (announcements.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref.read(announcementsProvider(projectId).notifier).refresh(),
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: Center(
                    child: Text('No announcements yet.', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(announcementsProvider(projectId).notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                return AnnouncementCard(announcement: announcements[index]);
              },
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
              const Text('Failed to load announcements'),
              ElevatedButton(
                onPressed: () => ref.read(announcementsProvider(projectId).notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

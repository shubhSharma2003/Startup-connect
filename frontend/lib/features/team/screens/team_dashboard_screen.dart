import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/team_workspace_provider.dart';
import '../widgets/team_stat_card.dart';

class TeamDashboardScreen extends ConsumerWidget {
  final String projectId;

  const TeamDashboardScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(teamWorkspaceProvider(projectId));

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Workspace Overview'),
      ),
      body: workspaceState.when(
        data: (workspace) {
          return RefreshIndicator(
            onRefresh: () => ref.read(teamWorkspaceProvider(projectId).notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workspace.projectTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.3,
                    children: [
                      TeamStatCard(
                        title: 'Active Members',
                        value: workspace.activeMembers.toString(),
                        icon: Icons.group,
                        color: AppColors.primary,
                      ),
                      TeamStatCard(
                        title: 'Pending Tasks',
                        value: workspace.pendingTasks.toString(),
                        icon: Icons.assignment_outlined,
                        color: Colors.orange,
                      ),
                      TeamStatCard(
                        title: 'Upcoming Deadlines',
                        value: workspace.upcomingDeadlines.toString(),
                        icon: Icons.timer_outlined,
                        color: AppColors.error,
                      ),
                      TeamStatCard(
                        title: 'Milestones Reached',
                        value: workspace.completedMilestones.toString(),
                        icon: Icons.emoji_events_outlined,
                        color: AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    context,
                    title: 'Manage Team',
                    subtitle: 'View members, assign roles, and manage access.',
                    icon: Icons.manage_accounts,
                    color: AppColors.primary,
                    onTap: () => context.push('/team/$projectId/members'),
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    context,
                    title: 'Project Tasks',
                    subtitle: 'Create, assign, and track progress.',
                    icon: Icons.list_alt,
                    color: Colors.indigo,
                    onTap: () => context.push('/team/$projectId/tasks'),
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    context,
                    title: 'Team Announcements',
                    subtitle: 'Broadcast updates and meeting notes.',
                    icon: Icons.campaign,
                    color: Colors.teal,
                    onTap: () => context.push('/team/$projectId/announcements'),
                  ),
                  const SizedBox(height: 12),
                  _buildActionCard(
                    context,
                    title: 'Project Files',
                    subtitle: 'Store and share project assets.',
                    icon: Icons.folder,
                    color: Colors.deepPurple,
                    onTap: () => context.push('/team/$projectId/files'),
                  ),
                ],
              ),
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
              const Text('Failed to load workspace'),
              ElevatedButton(
                onPressed: () => ref.read(teamWorkspaceProvider(projectId).notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/team_workspace_provider.dart';
import '../widgets/team_member_list_tile.dart';

class TeamMembersScreen extends ConsumerWidget {
  final String projectId;

  const TeamMembersScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(teamWorkspaceProvider(projectId));

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Manage Team'),
      ),
      body: workspaceState.when(
        data: (workspace) {
          if (workspace.members.isEmpty) {
            return const Center(child: Text('No members found.'));
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(teamWorkspaceProvider(projectId).notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: workspace.members.length,
              itemBuilder: (context, index) {
                final member = workspace.members[index];
                return Column(
                  children: [
                    TeamMemberListTile(
                      projectId: projectId,
                      member: member,
                    ),
                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.orange),
                      title: const Text('View Reviews'),
                      onTap: () {
                        context.push('/users/${member.id}/reviews');
                      },
                    ),
                    const Divider(),
                  ],
                );
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
              const Text('Failed to load team members'),
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
}

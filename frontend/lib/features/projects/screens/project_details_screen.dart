import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/project_details_provider.dart';
import '../widgets/project_info_header.dart';
import '../widgets/project_team_list.dart';
import '../widgets/project_apply_bottom_bar.dart';
import '../../profile/widgets/skills_chip_section.dart'; // Reusing from profile module
import '../../profile/models/skill_model.dart'; // Reusing from profile module
import 'package:shimmer/shimmer.dart';

class ProjectDetailsScreen extends ConsumerWidget {
  final String projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = ref.watch(projectDetailsProvider(projectId));

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Project Details'),
      ),
      body: detailsState.when(
        data: (project) {
          // Convert required string skills to SkillModel to reuse profile widget
          final skillsAsModels = project.requiredSkills.asMap().entries.map((e) => SkillModel(id: e.key, name: e.value)).toList();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProjectInfoHeader(project: project),
                      const SizedBox(height: 24),
                      Text(
                        'About the Project',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project.fullDescription,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Required Skills',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      SkillsChipSection(skills: skillsAsModels), // Reused Profile Widget
                      const SizedBox(height: 32),
                      Text(
                        'Team Members',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ProjectTeamList(teamMembers: project.teamMembers),
                      const SizedBox(height: 48), // Padding before bottom bar
                    ],
                  ),
                ),
              ),
              ProjectApplyBottomBar(project: project),
            ],
          );
        },
        loading: () => _buildShimmer(context),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              Text('Failed to load project details', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(projectDetailsProvider(projectId).notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 100, width: double.infinity, color: Colors.white),
            const SizedBox(height: 24),
            Container(height: 24, width: 200, color: Colors.white),
            const SizedBox(height: 12),
            Container(height: 200, width: double.infinity, color: Colors.white),
            const SizedBox(height: 24),
            Container(height: 24, width: 150, color: Colors.white),
            const SizedBox(height: 12),
            Container(height: 80, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/statistics_row.dart';
import '../widgets/skills_chip_section.dart';
import '../widgets/portfolio_links_section.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return BaseScaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/profile/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // ignore: unused_result
          ref.refresh(profileProvider);
        },
        child: profileState.when(
          data: (profile) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeaderCard(profile: profile),
                const SizedBox(height: 24),
                StatisticsRow(profile: profile),
                const SizedBox(height: 32),
                _SectionTitle('About'),
                Text(
                  profile.bio ?? 'No bio provided yet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
                const SizedBox(height: 24),
                _SectionTitle('Skills'),
                SkillsChipSection(skills: profile.skills),
                const SizedBox(height: 24),
                _SectionTitle('Portfolio & Links'),
                PortfolioLinksSection(links: profile.portfolioLinks),
                const SizedBox(height: 24),
                _SectionTitle('Resume'),
                if (profile.resumeUrl != null)
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.picture_as_pdf, color: AppColors.error),
                      title: const Text('View Resume', style: TextStyle(fontWeight: FontWeight.w600)),
                      trailing: const Icon(Icons.download_rounded),
                      onTap: () {}, // Download/Open Resume
                    ),
                  )
                else
                  const Text('No resume uploaded.', style: TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 32),
                _SectionTitle('Menu'),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.work_outline, color: AppColors.primary),
                        title: const Text('My Applications', style: TextStyle(fontWeight: FontWeight.w600)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/applications'),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.dashboard_customize_outlined, color: Colors.indigo),
                        title: const Text('My Workspaces', style: TextStyle(fontWeight: FontWeight.w600)),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/team/proj_mock_1/dashboard'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          loading: () => _buildShimmer(context),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                const SizedBox(height: 16),
                Text('Failed to load profile', style: Theme.of(context).textTheme.titleLarge),
                TextButton(
                  onPressed: () => ref.refresh(profileProvider),
                  child: const Text('Retry'),
                )
              ],
            ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

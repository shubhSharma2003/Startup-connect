import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/projects_provider.dart';
import '../widgets/project_card.dart';
import '../widgets/project_search_bar.dart';
import '../widgets/project_skeleton_list.dart';

class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(projectsProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectsState = ref.watch(projectsProvider);

    return BaseScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/projects/create/new'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Create Project', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(projectsProvider.notifier).refresh();
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              title: const Text('Discover Projects', style: TextStyle(fontWeight: FontWeight.bold)),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(72),
                child: ProjectSearchBar(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: projectsState.when(
                data: (state) {
                  if (state.projects.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 80, color: AppColors.textSecondary.withValues(alpha: 0.5)),
                            const SizedBox(height: 16),
                            Text('No projects found', style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 8),
                            const Text('Try adjusting your search or filters.', style: TextStyle(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == state.projects.length) {
                          // Bottom loader
                          if (state.hasMore) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Center(child: Text("You've reached the end!", style: TextStyle(color: AppColors.textSecondary))),
                            );
                          }
                        }
                        return ProjectCard(project: state.projects[index]);
                      },
                      childCount: state.projects.length + 1,
                    ),
                  );
                },
                loading: () => const ProjectSkeletonList(),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                        const SizedBox(height: 16),
                        Text('Failed to load projects', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.read(projectsProvider.notifier).refresh(),
                          child: const Text('Retry'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

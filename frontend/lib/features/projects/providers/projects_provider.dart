import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_model.dart';
import '../repositories/project_repository.dart';
import 'project_filter_provider.dart';

class ProjectsState {
  final List<ProjectModel> projects;
  final bool hasMore;
  final int page;
  final bool isFetchingMore;

  ProjectsState({
    this.projects = const [],
    this.hasMore = true,
    this.page = 1,
    this.isFetchingMore = false,
  });

  ProjectsState copyWith({
    List<ProjectModel>? projects,
    bool? hasMore,
    int? page,
    bool? isFetchingMore,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

final projectsProvider = AsyncNotifierProvider<ProjectsNotifier, ProjectsState>(() {
  return ProjectsNotifier();
});

class ProjectsNotifier extends AsyncNotifier<ProjectsState> {
  static const int _limit = 10;
  
  @override
  Future<ProjectsState> build() async {
    // Watch filter so this naturally rebuilds/refetches when filters change
    final filter = ref.watch(projectFilterProvider);
    final repo = ref.watch(projectRepositoryProvider);
    
    final result = await repo.getProjects(page: 1, limit: _limit, filter: filter);
    
    return ProjectsState(
      projects: result.projects,
      hasMore: result.hasMore,
      page: 1,
      isFetchingMore: false,
    );
  }

  Future<void> fetchNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isFetchingMore) return;

    // Set fetching more state
    state = AsyncData(current.copyWith(isFetchingMore: true));

    try {
      final repo = ref.read(projectRepositoryProvider);
      final filter = ref.read(projectFilterProvider);
      final nextPage = current.page + 1;

      final result = await repo.getProjects(page: nextPage, limit: _limit, filter: filter);

      state = AsyncData(current.copyWith(
        projects: [...current.projects, ...result.projects],
        hasMore: result.hasMore,
        page: nextPage,
        isFetchingMore: false,
      ));
    } catch (e, st) {
      // Revert fetching state on error, you could also dispatch a toast
      state = AsyncData(current.copyWith(isFetchingMore: false));
    }
  }

  Future<void> refresh() async {
    // Invalidate will trigger `build()` again
    ref.invalidateSelf();
  }
}

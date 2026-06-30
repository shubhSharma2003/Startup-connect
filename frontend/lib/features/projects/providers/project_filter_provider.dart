import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_filter_model.dart';

class ProjectFilterNotifier extends StateNotifier<ProjectFilterModel> {
  ProjectFilterNotifier() : super(const ProjectFilterModel());

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateStatusFilter(String? status) {
    state = state.copyWith(status: status);
  }

  void clearFilters() {
    state = const ProjectFilterModel();
  }
}

final projectFilterProvider = StateNotifierProvider<ProjectFilterNotifier, ProjectFilterModel>((ref) {
  return ProjectFilterNotifier();
});

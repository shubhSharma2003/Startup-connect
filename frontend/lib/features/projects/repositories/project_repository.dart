import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../models/project_model.dart';
import '../models/project_filter_model.dart';
import '../models/project_details_model.dart';
import '../models/team_member_model.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository(ref.watch(dioClientProvider).dio);
});

class PaginatedProjects {
  final List<ProjectModel> projects;
  final bool hasMore;

  PaginatedProjects({required this.projects, required this.hasMore});
}

class ProjectRepository {
  final Dio _dio;

  ProjectRepository(this._dio);

  Future<PaginatedProjects> getProjects({
    required int page,
    required int limit,
    required ProjectFilterModel filter,
  }) async {
    try {
      // Mock network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock implementation: generating dummy data based on page and filter
      List<ProjectModel> dummyProjects = List.generate(
        10,
        (index) => ProjectModel(
          id: 'proj_${page}_$index',
          title: 'Startup Idea ${page * 10 + index}',
          shortDescription: 'This is a revolutionary idea that will change the world using AI and Blockchain.',
          ownerName: 'Founder $index',
          status: index % 3 == 0 ? 'CLOSED' : 'OPEN',
          createdAt: DateTime.now().subtract(Duration(days: index)),
          requiredSkills: ['Flutter', 'Node.js', 'Figma'],
          teamSize: index % 5,
          maxTeamSize: 5,
        ),
      );

      // Apply search filter locally for mock
      if (filter.searchQuery.isNotEmpty) {
        dummyProjects = dummyProjects
            .where((p) => p.title.toLowerCase().contains(filter.searchQuery.toLowerCase()))
            .toList();
      }

      // Apply status filter locally for mock
      if (filter.status != null && filter.status!.isNotEmpty) {
        dummyProjects = dummyProjects
            .where((p) => p.status.toUpperCase() == filter.status!.toUpperCase())
            .toList();
      }

      // If we ask for page > 3, return no more results to simulate end of list
      final hasMore = page < 3;

      return PaginatedProjects(
        projects: hasMore ? dummyProjects : [],
        hasMore: hasMore,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ProjectDetailsModel> getProjectById(String id) async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Mock Network

      // Return rich mock data
      return ProjectDetailsModel(
        id: id,
        title: 'Project $id',
        fullDescription: 'This is the full, comprehensive description for project $id. We are looking for talented individuals to join our core team and help build the MVP. The platform connects students with startups across the country, providing real-world experience and networking opportunities. We need frontend developers experienced with Flutter and backend engineers familiar with Java Spring Boot. Our architecture relies heavily on clean code principles, containerization, and modern UI/UX design.\n\nJoin us on this exciting journey to revolutionize student collaboration!',
        ownerName: 'Alice Smith',
        ownerId: 'user_123',
        status: 'OPEN',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        requiredSkills: ['Flutter', 'Riverpod', 'Java', 'Docker'],
        maxTeamSize: 5,
        applicationStatus: ApplicationStatus.NONE,
        teamMembers: [
          const TeamMemberModel(id: 'tm_1', name: 'Alice Smith', role: 'Founder & CEO'),
          const TeamMemberModel(id: 'tm_2', name: 'Bob Jones', role: 'Backend Lead'),
        ],
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> applyToProject(String projectId) async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Mock Network Delay
      // final response = await _dio.post('/projects/$projectId/apply');
      // In a real app we might return the new status or check for errors
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ProjectDetailsModel> createProject(Map<String, dynamic> data) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // final response = await _dio.post('/projects', data: data);
      return ProjectDetailsModel(
        id: 'new_1',
        title: 'New Project',
        fullDescription: 'Mocked creation',
        ownerName: 'Mock Owner',
        ownerId: 'mock_1',
        status: 'OPEN',
        createdAt: DateTime.now(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<ProjectDetailsModel> updateProject(String id, Map<String, dynamic> data) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // final response = await _dio.put('/projects/$id', data: data);
      return ProjectDetailsModel(
        id: 'new_1',
        title: 'Updated Project',
        fullDescription: 'Mocked update',
        ownerName: 'Mock Owner',
        ownerId: 'mock_1',
        status: 'OPEN',
        createdAt: DateTime.now(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      return Exception(message);
    }
    return Exception(e.message ?? 'Network error occurred');
  }
}

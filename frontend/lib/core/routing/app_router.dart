import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/reset_password_screen.dart';
import '../../features/auth/providers/auth_provider.dart';

import '../../features/dashboard/screens/main_dashboard_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/projects/screens/projects_screen.dart';
import '../../features/projects/screens/project_details_screen.dart';
import '../../features/projects/screens/project_form_screen.dart';
import '../../features/applications/screens/applications_screen.dart';
import '../../features/team/screens/team_dashboard_screen.dart';
import '../../features/team/screens/team_members_screen.dart';
import '../../features/tasks/screens/tasks_screen.dart';
import '../../features/tasks/screens/task_form_screen.dart';
import '../../features/tasks/screens/task_details_screen.dart';
import '../../features/tasks/models/task_model.dart';
import '../../features/announcements/screens/announcements_screen.dart';
import '../../features/announcements/screens/announcement_form_screen.dart';
import '../../features/announcements/screens/announcement_details_screen.dart';
import '../../features/announcements/models/announcement_model.dart';
import '../../features/files/screens/files_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';

// Provide GoRouter globally
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuthRoute = state.uri.toString() == '/login' ||
          state.uri.toString() == '/register' ||
          state.uri.toString() == '/splash' ||
          state.uri.toString() == '/forgot-password' ||
          state.uri.toString() == '/reset-password';

      // If app is still loading on splash, don't redirect yet
      if (state.uri.toString() == '/splash') return null;

      // Unauthenticated users trying to access protected routes
      if (authState.user == null && !isAuthRoute) {
        return '/login';
      }

      // Authenticated users trying to access auth routes
      if (authState.user != null && isAuthRoute) {
        return '/home';
      }

      return null; // Proceed as normal
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/applications',
        builder: (context, state) => const ApplicationsScreen(),
      ),
      GoRoute(
        path: '/team/:id/dashboard',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TeamDashboardScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/team/:id/members',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TeamMembersScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/team/:id/tasks',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TasksScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/team/:id/tasks/new',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TaskFormScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/team/:id/tasks/:taskId',
        builder: (context, state) {
          final task = state.extra as TaskModel;
          return TaskDetailsScreen(task: task);
        },
      ),
      GoRoute(
        path: '/team/:id/announcements',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AnnouncementsScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/team/:id/announcements/new',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AnnouncementFormScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/team/:id/announcements/:announcementId',
        builder: (context, state) {
          final announcement = state.extra as AnnouncementModel;
          return AnnouncementDetailsScreen(announcement: announcement);
        },
      ),
      GoRoute(
        path: '/team/:id/files',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FilesScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/projects/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProjectDetailsScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/projects/:id/edit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProjectFormScreen(projectId: id);
        },
      ),
      GoRoute(
        path: '/projects/create/new', // use nested to avoid conflict with /:id if not careful, actually /projects/create is fine if put before /:id, but since we put it after, let's use /project-create or put it before. Let's put it before or just use an absolute path.
        builder: (context, state) => const ProjectFormScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainDashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/projects',
                builder: (context, state) => const ProjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri.toString()}'),
      ),
    ),
  );
});

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../models/team_member_model.dart';

class ProjectTeamList extends StatelessWidget {
  final List<TeamMemberModel> teamMembers;

  const ProjectTeamList({super.key, required this.teamMembers});

  @override
  Widget build(BuildContext context) {
    if (teamMembers.isEmpty) {
      return const Text('No team members yet.', style: TextStyle(color: AppColors.textSecondary));
    }

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: teamMembers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final member = teamMembers[index];
          return SizedBox(
            width: 100,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  backgroundImage: member.avatarUrl != null ? CachedNetworkImageProvider(member.avatarUrl!) : null,
                  child: member.avatarUrl == null
                      ? const Icon(Icons.person, color: AppColors.primary, size: 32)
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  member.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  member.role,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

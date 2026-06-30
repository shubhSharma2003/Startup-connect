import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../models/team_member_extended_model.dart';
import '../providers/team_member_mutation_provider.dart';
import 'role_management_bottom_sheet.dart';

class TeamMemberListTile extends ConsumerWidget {
  final String projectId;
  final TeamMemberExtendedModel member;

  const TeamMemberListTile({super.key, required this.projectId, required this.member});

  void _showRoleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RoleManagementBottomSheet(projectId: projectId, member: member),
    );
  }

  void _confirmRemove(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Member?'),
        content: Text('Are you sure you want to remove ${member.name} from the project?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(teamMemberMutationProvider.notifier).removeMember(projectId, member.id);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color badgeColor;
    String roleText = member.role.name;

    switch (member.role) {
      case TeamRole.OWNER:
        badgeColor = Colors.purple;
        break;
      case TeamRole.ADMIN:
        badgeColor = AppColors.success;
        break;
      case TeamRole.MEMBER:
        badgeColor = AppColors.primary;
        break;
      case TeamRole.VIEWER:
        badgeColor = Colors.grey;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            backgroundImage: member.avatarUrl != null ? CachedNetworkImageProvider(member.avatarUrl!) : null,
            child: member.avatarUrl == null ? const Icon(Icons.person, color: AppColors.primary) : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(member.title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              roleText,
              style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
          if (member.role != TeamRole.OWNER)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
              onSelected: (value) {
                if (value == 'change_role') {
                  _showRoleSheet(context);
                } else if (value == 'remove') {
                  _confirmRemove(context, ref);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'change_role',
                  child: Row(
                    children: [
                      Icon(Icons.manage_accounts_outlined, size: 20),
                      SizedBox(width: 8),
                      Text('Change Role'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'remove',
                  child: Row(
                    children: [
                      Icon(Icons.person_remove_outlined, color: AppColors.error, size: 20),
                      SizedBox(width: 8),
                      Text('Remove Member', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

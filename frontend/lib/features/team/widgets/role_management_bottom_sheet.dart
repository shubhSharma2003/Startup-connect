import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../models/team_member_extended_model.dart';
import '../providers/team_member_mutation_provider.dart';

class RoleManagementBottomSheet extends ConsumerWidget {
  final String projectId;
  final TeamMemberExtendedModel member;

  const RoleManagementBottomSheet({
    super.key,
    required this.projectId,
    required this.member,
  });

  void _updateRole(BuildContext context, WidgetRef ref, TeamRole newRole) async {
    final success = await ref.read(teamMemberMutationProvider.notifier).updateRole(projectId, member.id, newRole);
    if (success && context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Role updated successfully'), backgroundColor: AppColors.success),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutationState = ref.watch(teamMemberMutationProvider);
    final isLoading = mutationState is AsyncLoading;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          Text('Manage Role for ${member.name}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          if (isLoading)
            const Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())
          else ...[
            _buildRoleTile(context, ref, TeamRole.ADMIN, 'Admin', 'Can manage project details and team members'),
            _buildRoleTile(context, ref, TeamRole.MEMBER, 'Member', 'Can view and contribute to tasks'),
            _buildRoleTile(context, ref, TeamRole.VIEWER, 'Viewer', 'Read-only access to the workspace'),
          ],
        ],
      ),
    );
  }

  Widget _buildRoleTile(BuildContext context, WidgetRef ref, TeamRole role, String title, String subtitle) {
    final isSelected = member.role == role;
    return ListTile(
      leading: Icon(
        Icons.shield,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.success) : null,
      onTap: isSelected ? null : () => _updateRole(context, ref, role),
    );
  }
}

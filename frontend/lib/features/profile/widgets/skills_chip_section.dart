import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/skill_model.dart';

class SkillsChipSection extends StatelessWidget {
  final List<SkillModel> skills;
  final bool isEditing;
  final void Function(int)? onRemove;

  const SkillsChipSection({
    super.key,
    required this.skills,
    this.isEditing = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty && !isEditing) {
      return const Text('No skills added yet.', style: TextStyle(color: AppColors.textSecondary));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return Chip(
          label: Text(skill.name),
          backgroundColor: AppColors.primary.withValues(alpha: 0.05),
          side: const BorderSide(color: AppColors.border),
          deleteIcon: isEditing ? const Icon(Icons.close, size: 16) : null,
          onDeleted: isEditing ? () => onRemove?.call(skill.id) : null,
          labelStyle: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
        );
      }).toList(),
    );
  }
}

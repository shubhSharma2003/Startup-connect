import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/portfolio_link.dart';

class PortfolioLinksSection extends StatelessWidget {
  final List<PortfolioLink> links;
  final bool isEditing;
  final void Function(int)? onRemove;

  const PortfolioLinksSection({
    super.key,
    required this.links,
    this.isEditing = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty && !isEditing) {
      return const Text('No links added yet.', style: TextStyle(color: AppColors.textSecondary));
    }

    return Column(
      children: links.map((link) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.border),
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.link, color: AppColors.primary),
            title: Text(link.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(link.url, style: const TextStyle(color: AppColors.textSecondary)),
            trailing: isEditing
                ? IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.error),
                    onPressed: () => onRemove?.call(link.id),
                  )
                : const Icon(Icons.open_in_new, size: 16),
            onTap: isEditing ? null : () {
              // TODO: Launch URL
            },
          ),
        );
      }).toList(),
    );
  }
}

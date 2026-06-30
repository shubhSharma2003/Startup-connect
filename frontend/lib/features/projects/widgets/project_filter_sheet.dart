import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/project_filter_provider.dart';

class ProjectFilterSheet extends ConsumerWidget {
  const ProjectFilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(projectFilterProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              )
            ],
          ),
          const SizedBox(height: 24),
          const Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              ChoiceChip(
                label: const Text('All'),
                selected: filter.status == null,
                onSelected: (selected) {
                  if (selected) ref.read(projectFilterProvider.notifier).updateStatusFilter(null);
                },
              ),
              ChoiceChip(
                label: const Text('Open'),
                selected: filter.status == 'OPEN',
                onSelected: (selected) {
                  if (selected) ref.read(projectFilterProvider.notifier).updateStatusFilter('OPEN');
                },
              ),
              ChoiceChip(
                label: const Text('Closed'),
                selected: filter.status == 'CLOSED',
                onSelected: (selected) {
                  if (selected) ref.read(projectFilterProvider.notifier).updateStatusFilter('CLOSED');
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(projectFilterProvider.notifier).clearFilters();
                    context.pop();
                  },
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Refetch is naturally handled by watching filter
                    context.pop();
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

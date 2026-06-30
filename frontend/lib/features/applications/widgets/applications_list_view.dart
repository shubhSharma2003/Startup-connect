import 'package:flutter/material.dart';
import '../models/application_model.dart';
import 'application_card.dart';
import '../../../core/constants/app_colors.dart';

class ApplicationsListView extends StatelessWidget {
  final List<ApplicationModel> applications;
  final Future<void> Function() onRefresh;

  const ApplicationsListView({
    super.key,
    required this.applications,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (applications.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.5)),
                const SizedBox(height: 16),
                const Text('No applications found.', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: applications.length,
        itemBuilder: (context, index) {
          return ApplicationCard(application: applications[index]);
        },
      ),
    );
  }
}

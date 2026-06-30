import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/task_model.dart';

class TaskStatusBadge extends StatelessWidget {
  final TaskStatus status;

  const TaskStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case TaskStatus.TODO:
        color = Colors.grey;
        text = 'TO DO';
        break;
      case TaskStatus.IN_PROGRESS:
        color = Colors.orange;
        text = 'IN PROGRESS';
        break;
      case TaskStatus.DONE:
        color = AppColors.success;
        text = 'DONE';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

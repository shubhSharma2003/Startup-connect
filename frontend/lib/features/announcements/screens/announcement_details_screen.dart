import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../models/announcement_model.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementDetailsScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Announcement'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (announcement.isImportant) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('IMPORTANT', style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              announcement.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  backgroundImage: announcement.authorAvatar != null ? CachedNetworkImageProvider(announcement.authorAvatar!) : null,
                  child: announcement.authorAvatar == null ? const Icon(Icons.person, color: AppColors.primary) : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(announcement.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('MMM d, yyyy • h:mm a').format(announcement.createdAt),
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Text(
              announcement.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

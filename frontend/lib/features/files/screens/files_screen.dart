import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import '../../../shared/widgets/base_scaffold.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/files_provider.dart';
import '../providers/file_mutation_provider.dart';
import '../widgets/file_card.dart';

class FilesScreen extends ConsumerWidget {
  final String projectId;

  const FilesScreen({super.key, required this.projectId});

  Future<void> _pickAndUploadFile(BuildContext context, WidgetRef ref) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        final platformFile = result.files.single;
        final extension = platformFile.extension ?? 'unknown';
        final name = platformFile.name.replaceAll('.$extension', '');
        final size = platformFile.size;
        final path = platformFile.path ?? '';

        if (!context.mounted) return;

        // Show uploading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Uploading ${platformFile.name}...'),
              ],
            ),
          ),
        );

        final success = await ref.read(fileMutationProvider.notifier).uploadFile(projectId, path, name, extension, size);
        
        if (context.mounted) {
          Navigator.pop(context); // Close dialog
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('File uploaded successfully!'), backgroundColor: AppColors.success),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to upload file.'), backgroundColor: AppColors.error),
            );
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error picking file.'), backgroundColor: AppColors.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filesState = ref.watch(filesProvider(projectId));

    return BaseScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Project Files'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _pickAndUploadFile(context, ref),
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: filesState.when(
        data: (files) {
          if (files.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref.read(filesProvider(projectId).notifier).refresh(),
              child: const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: Center(
                    child: Text('No files uploaded yet.', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(filesProvider(projectId).notifier).refresh(),
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85, // Taller cards to fit text
              ),
              itemCount: files.length,
              itemBuilder: (context, index) {
                return FileCard(file: files[index]);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              const Text('Failed to load files'),
              ElevatedButton(
                onPressed: () => ref.read(filesProvider(projectId).notifier).refresh(),
                child: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

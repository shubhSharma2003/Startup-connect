import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';

class ProjectImagePicker extends StatelessWidget {
  final XFile? image;
  final VoidCallback onPick;

  const ProjectImagePicker({super.key, this.image, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: image == null ? AppColors.border : AppColors.primary,
            width: 2,
            style: image == null ? BorderStyle.solid : BorderStyle.solid,
          ),
          image: image != null
              ? DecorationImage(
                  image: FileImage(File(image!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 48, color: AppColors.primary.withValues(alpha: 0.5)),
                  const SizedBox(height: 12),
                  const Text('Upload Cover Image', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text('16:9 ratio recommended', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(Icons.edit, color: Colors.white, size: 32),
                ),
              ),
      ),
    );
  }
}

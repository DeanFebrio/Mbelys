import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/presentation/widgets/custom_short_button.dart';

class CustomAddImage extends StatelessWidget {
  final File? localPhoto;
  final Future<File?> Function() pickImage;
  final void Function(File file) onPicked;

  const CustomAddImage({
    super.key,
    required this.pickImage,
    required this.onPicked,
    this.localPhoto,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocal = localPhoto != null;

    return Container(
      width: 330,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.color6,
        borderRadius: BorderRadius.circular(10),
        border: hasLocal ? Border.all(color: AppColors.color9, width: 2) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasLocal)
            Image.file(localPhoto!, fit: BoxFit.cover),
          Center(
            child: CustomShortButton(
              onTap: () async {
                final file = await pickImage();
                if (file != null) onPicked(file);
              },
              buttonText: hasLocal ? "Ganti Gambar" : "Tambah Gambar",
              isOnTop: hasLocal,
            ),
          ),
        ],
      ),
    );
  }
}

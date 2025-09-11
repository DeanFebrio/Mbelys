import 'dart:io';
import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/goat_shed/presentation/viewmodel/add_viewmodel.dart";
import "package:mbelys/presentation/widgets/custom_pick_image.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import 'package:provider/provider.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AddViewModel>();
    final File? selectedImage = vm.localPhoto;

    return Container(
      width: 330,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.color6,
        borderRadius: BorderRadius.circular(10),
        border: selectedImage != null ? Border.all(color: AppColors.color9, width: 2) : null,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (selectedImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                selectedImage,
                fit: BoxFit.cover,
                width: 330,
                height: 150,
              ),
            ),
          Center(
            child: CustomShortButton(
              onTap: () async {
                final File? imageFile = await CustomPickImage.showImagePickerOptions(context);
                if (imageFile != null) {
                  vm.setImage(imageFile);
                }
              },
              buttonText: selectedImage != null ? "Ganti Gambar" : "Tambah Gambar",
              isOnTop:  selectedImage != null ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
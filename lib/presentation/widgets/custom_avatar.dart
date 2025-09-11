import "dart:io";

import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CustomAvatar extends StatelessWidget {
  final double radius;
  final File? localImageFile;
  final String? photoUrl;
  final String defaultAvatar;

  const CustomAvatar({
    super.key,
    this.radius = 37,
    this.localImageFile,
    this.photoUrl,
    this.defaultAvatar = "assets/images/mbeky_avatar.png",
  });

  ImageProvider _pickImage() {
    if (localImageFile != null) return FileImage(localImageFile!);
    if (photoUrl != null && photoUrl!.isNotEmpty) return NetworkImage(photoUrl!);
    return AssetImage(defaultAvatar);
  }

  @override
  Widget build(BuildContext context) {
    final img = _pickImage();
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.color10,
      child: CircleAvatar(
        backgroundColor: AppColors.color2,
        radius: radius - 4,
        child: CircleAvatar(
          backgroundColor: AppColors.color2,
          radius: radius - 7,
          foregroundImage: img,
        ),
      ),
    );
  }
}

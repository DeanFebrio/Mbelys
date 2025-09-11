import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbelys/core/constant/app_colors.dart';

class CustomPickImage {
  static Future<File?> showImagePickerOptions (BuildContext context) async {
    final fontStyle = TextStyle(
        fontSize: 18,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        color: AppColors.color3
    );

    return await showModalBottomSheet<File>(
        context: context,
        backgroundColor: AppColors.color9,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.color3,
                  ),
                  title: Text(
                    'Galeri',
                    style: fontStyle,
                  ),
                  onTap: () async {
                    final file = await _pickImage(ImageSource.gallery);
                    if (!context.mounted) return;
                    Navigator.of(context).pop(file);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: AppColors.color3,
                  ),
                  title: Text(
                    'Kamera',
                    style: fontStyle,
                  ),
                  onTap: () async {
                    final file = await _pickImage(ImageSource.camera);
                    if (!context.mounted) return;
                    Navigator.of(context).pop(file);
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  static Future<File?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
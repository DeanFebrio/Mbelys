import 'package:flutter/material.dart';
import 'package:mbelys/core/constant/app_colors.dart';

void showErrorSnackBar (BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            message ?? "Terjadi kesalahan!",
            style: TextStyle(
                color: AppColors.color2,
                fontSize: 16,
                fontFamily: "Mulish",
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        backgroundColor: AppColors.color5,
      )
  );
}
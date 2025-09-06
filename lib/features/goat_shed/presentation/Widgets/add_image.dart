import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.color6,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: CustomShortButton(
            onTap: (){},
            buttonText: "Tambah Gambar"
        ),
      ),
    );
  }
}

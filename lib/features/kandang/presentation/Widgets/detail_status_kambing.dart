import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/kandang/presentation/Widgets/custom_label_status.dart";

class StatusKambing extends StatelessWidget {
  const StatusKambing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Status Kondisi Kambing",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: AppColors.color9
          ),
        ),
        const SizedBox(height: 5,),
        CustomLabelStatus(
          labelText: "Stres terdeteksi",
        ),
        const SizedBox(height: 10,),
        CustomLabelStatus(
          labelText: "Masa Subur tidak terdeteksi",
        )
      ],
    );
  }
}

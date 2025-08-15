import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class InformasiKandang extends StatelessWidget {
  const InformasiKandang({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("🐐"),
            const SizedBox(width: 5,),
            Text(
              "Jumlah Kambing: ",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.color1
              ),
            ),
            Text(
              "20",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color9
              ),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍"),
            const SizedBox(width: 5,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lokasi:",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: AppColors.color1
                    ),
                  ),
                  Text(
                    "Sekolah Santo Yakobus, Kelapa Gading, Jakarta Utara",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        color: AppColors.color9
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

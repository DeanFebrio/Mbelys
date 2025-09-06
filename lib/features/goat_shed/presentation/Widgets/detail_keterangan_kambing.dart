import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";

class KeteranganKambing extends StatelessWidget {
  const KeteranganKambing({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Keterangan:",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            color: AppColors.color9,
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          "Berdasarkan analisis suara terbaru, kambing di goat_shed ini "
              "menunjukkan tanda-tanda stres, namun tidak sedang dalam "
              "kondisi birahi. Deteksi stres dapat disebabkan oleh "
              "beberapa faktor lingkungan seperti suhu goat_shed yang terlalu "
              "panas, suara bising dari luar, atau kondisi goat_shed yang "
              "terlalu padat. Kambing yang stres cenderung mengeluarkan "
              "vokalisasi bernada tinggi atau bersifat berulang. "
              "Sementara itu, tidak terdeteksinya birahi menunjukkan "
              "bahwa kambing belum berada dalam siklus kawin yang aktif.",
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Mulish",
              fontWeight: FontWeight.w500,
              color: AppColors.color1
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

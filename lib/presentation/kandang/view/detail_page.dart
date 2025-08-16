import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/kandang/Widgets/custom_edit_button.dart";
import "package:mbelys/presentation/kandang/Widgets/detail_background_page.dart";
import "package:mbelys/presentation/kandang/Widgets/detail_informasi_kandang.dart";
import "package:mbelys/presentation/kandang/Widgets/detail_keterangan_kambing.dart";
import "package:mbelys/presentation/kandang/Widgets/detail_saran_penanganan.dart";
import "package:mbelys/presentation/kandang/Widgets/detail_status_kambing.dart";

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailBackgroundPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kandang B",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color9
                ),
              ),
              const CustomEditButton()
            ],
          ),
          const SizedBox(height: 10,),
          InformasiKandang(),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: StatusKambing(),
          ),
          const SizedBox(height: 20,),
          KeteranganKambing(),
          const SizedBox(height: 20,),
          SaranPenanganan(),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}

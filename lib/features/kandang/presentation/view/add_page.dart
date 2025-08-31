import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/features/kandang/presentation/Widgets/add_image.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import "package:mbelys/presentation/widgets/custom_dialog.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {

    final formTextStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    return CustomBackgroundPage(
        title: "Detail Kandang",
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(),
                    const SizedBox(height: 15,),
                    Text(
                      "Gambar Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    AddImage(),
                    const SizedBox(height: 15,),
                    Text(
                      "Lokasi Kandang",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(),
                    const SizedBox(height: 10,),
                    Text(
                      "Jumlah Kambing",
                      style: formTextStyle,
                    ),
                    const SizedBox(height: 5,),
                    CustomTextInput(),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              CustomShortButton(
                  onTap: () => customDialog(
                      context,
                      "Berhasil ditambahkan",
                      "Kandang baru Anda kini terintegrasi dengan perangkat IoT. "
                          "Pemantauan suara akan segera dimulai.",
                      "Baik",
                      RouterPath.home
                  ),
                  buttonText: "Simpan"
              )
            ],
          ),
        )
    );
  }
}

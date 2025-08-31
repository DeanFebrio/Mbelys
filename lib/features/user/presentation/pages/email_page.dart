import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";
import "package:mbelys/presentation/widgets/custom_long_button.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";

class EmailPage extends StatelessWidget {
  const EmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formTextStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    return CustomBackgroundPage(
      title: "Ubah Email",
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 120,),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Baru",
                    style: formTextStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            CustomLongButton(
                onTap: () {
                  context.go(RouterPath.profile);
                },
                textButton: "Simpan",
                textColor: AppColors.color3,
                backgroundColor: AppColors.color9
            )
          ],
        ),
      ),
    );
  }
}

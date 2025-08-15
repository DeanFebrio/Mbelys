import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/presentation/profile/widgets/custom_change_button.dart";
import "package:mbelys/presentation/profile/widgets/edit_profil_background_page.dart";
import "package:mbelys/presentation/profile/widgets/edit_save_button.dart";
import "package:mbelys/presentation/profile/widgets/password_button.dart";
import "package:mbelys/presentation/widgets/custom_avatar.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final textStyle = TextStyle(
      fontSize: 20,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w700,
      color: AppColors.color9
    );

    return EditProfileBackgroundPage(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.01),
            CustomAvatar(radius: 70,),
            const SizedBox(height: 6,),
            CustomChangeButton(
                onTap: () {
                  context.go(RouterPath.profile);
                }
            ),
            const SizedBox(height: 15,),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama",
                    style: textStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(),
                  const SizedBox(height: 10,),
                  Text(
                    "Email",
                    style: textStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(),
                  const SizedBox(height: 10,),
                  Text(
                    "Nomor Telepon",
                    style: textStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const PasswordButton(),
            const SizedBox(height: 30,),
            const EditSaveButton()
          ],
        ),
      ),
    );
  }
}

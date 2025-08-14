import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/edit_profil/widgets/password_button.dart";
import "package:mbelys/view/pages/edit_profil/widgets/edit_profil_background_page.dart";
import "package:mbelys/view/pages/edit_profil/widgets/edit_save_button.dart";
import "package:mbelys/view/pages/profil/profil_page.dart";
import "package:mbelys/view/widgets/custom_avatar.dart";
import "package:mbelys/view/widgets/custom_change_button.dart";
import "package:mbelys/view/widgets/custom_text_input.dart";

class EditProfilPage extends StatelessWidget {
  const EditProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final textStyle = TextStyle(
      fontSize: 20,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w700,
      color: AppColors.color9
    );

    return EditProfilBackgroundPage(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 0.08 * screenHeight,),
            CustomAvatar(radius: 70,),
            const SizedBox(height: 6,),
            CustomChangeButton(onTap: ProfilPage()),
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
            PasswordButton(),
            const SizedBox(height: 20,),
            EditSaveButton()
          ],
        ),
      ),
    );
  }
}

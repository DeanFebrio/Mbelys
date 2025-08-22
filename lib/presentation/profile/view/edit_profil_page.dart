import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/presentation/profile/viewmodel/profile_viewmodel.dart";
import "package:mbelys/presentation/profile/widgets/custom_change_button.dart";
import "package:mbelys/presentation/profile/widgets/edit_profile_background_page.dart";
import "package:mbelys/presentation/profile/widgets/password_button.dart";
import "package:mbelys/presentation/widgets/custom_avatar.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";
import "package:provider/provider.dart";

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ProfileViewModel>(),
      child: const EditProfileView(),
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final textStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    final vm = context.watch<ProfileViewModel>();
    final user = vm.user;

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
                  CustomTextInput(
                    hintText: user?.name,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "Email",
                    style: textStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(
                    hintText: user?.email,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "Nomor Telepon",
                    style: textStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(
                    hintText: user?.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25,),
            const PasswordButton(),
            const SizedBox(height: 30,),
            CustomShortButton(
                onTap: () => context.go(RouterPath.profile),
                buttonText: "Simpan"
            )
          ],
        ),
      ),
    );
  }
}

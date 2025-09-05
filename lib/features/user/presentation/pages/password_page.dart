import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/user/presentation/viewmodels/password_viewmodel.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";
import "package:mbelys/presentation/widgets/custom_dialog.dart";
import "package:mbelys/presentation/widgets/custom_long_button.dart";
import "package:mbelys/presentation/widgets/custom_snackbar.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";
import "package:provider/provider.dart";

class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<PasswordViewModel>(),
      child: const PasswordView(),
    );
  }
}

class PasswordView extends StatelessWidget {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formTextStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    final vm = context.watch<PasswordViewModel>();
    final state = vm.state;

    return CustomBackgroundPage(
      title: "Ubah Password",
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 120,),
            Form(
              key: vm.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password Lama",
                    style: formTextStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(
                    isPassword: true,
                    textEditingController: vm.oldPasswordController,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "Password Baru",
                    style: formTextStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(
                    isPassword: true,
                    textEditingController: vm.newPasswordController,
                    validator: vm.validatePassword,
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "Konfirmasi Password",
                    style: formTextStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(
                    isPassword: true,
                    textEditingController: vm.confirmPasswordController,
                    validator: vm.validateConfirmPassword,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            CustomLongButton(
                onTap: state == PasswordState.loading ? null : () async {
                  await vm.changePassword();
                  if (!context.mounted) return;
                  if (vm.state == PasswordState.error) {
                    showErrorSnackBar(context, vm.errorMessage);
                  } else if (vm.state == PasswordState.success){
                    customDialog(
                        context,
                        "Password berhasil diubah",
                        "Anda dapat menggunakan password baru untuk masuk aplikasi",
                        "Baik",
                        RouterPath.home
                    );
                  }
                },
                textButton: "Simpan",
                textColor: AppColors.color3,
                backgroundColor: AppColors.color9
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                context.push(RouterPath.forgot);
              },
              child: Text(
                "Lupa password?",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: AppColors.color8
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/auth/presentation/viewmodels/forgot_viewmodel.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";
import "package:mbelys/presentation/widgets/custom_long_button.dart";
import "package:mbelys/presentation/widgets/custom_dialog.dart";
import "package:mbelys/presentation/widgets/custom_snackbar.dart";
import "package:mbelys/presentation/widgets/custom_text_input.dart";
import "package:provider/provider.dart";

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ForgotViewModel>(),
      child: const ForgotView(),
    );
  }
}

class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    final formTextStyle = TextStyle(
        fontSize: 20,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        color: AppColors.color9
    );

    final vm = context.watch<ForgotViewModel>();
    final state = vm.state;

    return CustomBackgroundPage(
      title: "Lupa Password",
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
                    "Masukkan email",
                    style: formTextStyle,
                  ),
                  const SizedBox(height: 5,),
                  CustomTextInput(
                    textEditingController: vm.emailController,
                    validator: vm.validateEmail,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            CustomLongButton(
                onTap: state == ForgotState.loading ? null : () async {
                  await vm.forgotPassword();
                  if(!context.mounted) return;
                  if (vm.state == ForgotState.error) {
                    showErrorSnackBar(
                        context,
                        vm.errorMessage ?? "Terjadi kesalahan!"
                    );
                  } else if (vm.state == ForgotState.success) {
                    customDialog(
                        context,
                        "Email Terkirim",
                        "Silahkan cek email anda untuk mengatur ulang sandi",
                        "Baik",
                        () => context.pop()
                    );
                  }
                },
                textButton: "Lanjut",
                textColor: AppColors.color3,
                backgroundColor: AppColors.color9
            )
          ],
        ),
      ),
    );
  }
}


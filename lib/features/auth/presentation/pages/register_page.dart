import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/auth/presentation/viewmodels/register_viewmodel.dart";
import "package:mbelys/features/auth/presentation/widgets/auth_background_page.dart";
import "package:mbelys/features/auth/presentation/widgets/auth_button.dart";
import "package:mbelys/features/auth/presentation/widgets/auth_divider.dart";
import "package:mbelys/features/auth/presentation/widgets/auth_text_input.dart";
import "package:mbelys/features/auth/presentation/widgets/facebook_button.dart";
import "package:mbelys/features/auth/presentation/widgets/google_button.dart";
import "package:provider/provider.dart";

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<RegisterViewModel>(),
      child: Consumer<RegisterViewModel>(
        builder: (context, vm, child) {
          return Stack(
            children: [
              RegisterView(),
              if (vm.state == RegisterState.loading)
                Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          );
        }
      )
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();

    return AuthBackgroundPage(
      title: "Daftar",
      child: SingleChildScrollView (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70,),
            FormSection(vm: vm),
            const SizedBox(height: 30,),
            RegisterButton(vm: vm),
            const SizedBox(height: 30,),
            AuthDivider(
              text: "Daftar dengan",
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleButton(),
                const SizedBox(width: 20,),
                FacebookButton()
              ],
            ),
            const SizedBox(height: 30,),
            LoginRedirect()
          ],
        ),
      ),
    );
  }
}

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sudah memiliki akun? ",
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: AppColors.color3
          ),
        ),
        GestureDetector(
          onTap: (){
            context.go(RouterPath.login);
          },
          child: Text(
            "Masuk",
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w700,
                color: AppColors.color3
            ),
          ),
        )
      ],
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.vm,
  });
  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RegisterViewModel>().state;

    return AuthButton(
      textButton: "Daftar",
      onPressed: state == RegisterState.loading ? null : () async {
        await vm.register();
        if (!context.mounted) return;
        if (vm.state == RegisterState.error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    vm.errorMessage ?? "Gagal mendaftar!",
                    style: TextStyle(
                      color: AppColors.color2,
                      fontSize: 16,
                      fontFamily: "Mulish",
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                backgroundColor: AppColors.color5,
              )
          );
        }
      },
    );
  }
}

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.vm,
  });

  final RegisterViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Form (
      key: vm.formKey,
      child: Column (
        children: [
          AuthTextInput(
            hintText: "Masukkan email",
            controller: vm.emailController,
            validator: vm.validateEmail,
            isPassword: false,
          ),
          const SizedBox(height: 10,),
          AuthTextInput(
            hintText: "Masukkan password",
            controller: vm.passwordController,
            validator: vm.validatePassword,
            isPassword: true,
          ),
          const SizedBox(height: 10,),
          AuthTextInput(
            hintText: "Masukkan nama",
            controller: vm.nameController,
            validator: vm.validateName,
            isPassword: false,
          ),
          const SizedBox(height: 10,),
          AuthTextInput(
            hintText: "Masukkan nomor telepon",
            controller: vm.phoneController,
            validator: vm.validatePhone,
            isPassword: false,
          ),
        ],
      ),
    );
  }
}


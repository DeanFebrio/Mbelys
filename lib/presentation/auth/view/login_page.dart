import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/presentation/auth/viewmodel/login_viewmodel.dart";
import "package:mbelys/presentation/auth/widgets/auth_background_page.dart";
import "package:mbelys/presentation/auth/widgets/auth_button.dart";
import "package:mbelys/presentation/auth/widgets/auth_divider.dart";
import "package:mbelys/presentation/auth/widgets/auth_text_input.dart";
import "package:mbelys/presentation/auth/widgets/facebook_button.dart";
import "package:mbelys/presentation/auth/widgets/google_button.dart";
import "package:provider/provider.dart";


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<LoginViewModel>(),
      child: Consumer<LoginViewModel>(
          builder: (context, vm, child) {
            return Stack(
              children: [
                LoginView(),
                if (vm.state == LoginState.loading)
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
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return AuthBackgroundPage(
        title: "Masuk",
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70,),
              FormSection(vm: vm),
              const SizedBox(height: 8,),
              SizedBox(
                width: 340,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      context.go(RouterPath.forgot);
                    },
                    child: Text(
                      "Lupa password?",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: AppColors.color3
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              LoginButton(vm: vm,),
              const SizedBox(height: 30,),
              AuthDivider(text: "Masuk dengan"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun? ",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: AppColors.color3
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      context.go(RouterPath.register);
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          color: AppColors.color3
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.vm
  });

  final LoginViewModel vm;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginViewModel>().state;

    return AuthButton(
      textButton: "Masuk",
      onPressed: state == LoginState.loading ? null : () async {
        await vm.login();
        if (!context.mounted) return;
        if (vm.state == LoginState.error) {
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
                backgroundColor: AppColors.color8,
              )
          );
        } else if (vm.state == LoginState.success) {
          print("User nih: ${vm.user?.name}");
          context.go(RouterPath.home);
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

  final LoginViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.formKey,
        child: Column(
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
          ],
        )
    );
  }
}

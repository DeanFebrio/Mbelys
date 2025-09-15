import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/feedback/presentation/viewmodels/feedback_viewmodel.dart";
import "package:mbelys/features/feedback/presentation/widgets/feedback_text_input.dart";
import "package:mbelys/presentation/widgets/custom_background_page.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import "package:mbelys/presentation/widgets/custom_dialog.dart";
import "package:mbelys/presentation/widgets/custom_snackbar.dart";
import "package:provider/provider.dart";

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<FeedbackViewModel>(),
      child: const FeedbackView(),
    );
  }
}

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FeedbackViewModel>();
    final state = vm.state;

    return CustomBackgroundPage(
        title: "Kritik dan Saran",
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 150,),
                Text(
                  "Apa kritik atau saran Anda untuk membantu kami memperbaiki Mbelys?",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                FeedbackTextInput(
                  textEditingController: vm.feedbackController,
                ),
                const SizedBox(height: 20,),
                CustomShortButton(
                    onTap: state == FeedbackState.loading ? null :  () async{
                      await vm.sendEmail();
                      if (!context.mounted) return;
                      if (vm.state == FeedbackState.error) {
                        showErrorSnackBar(context, vm.errorMessage);
                      } else if (vm.state == FeedbackState.success) {
                        customDialog(
                          context,
                          "Kritik & Saran terkirim",
                          "Terima kasih atas kritik dan saran yang berguna untuk membangun aplikasi",
                          "Baik",
                            () => context.pop()
                        );
                      }
                    },
                    buttonText: "Kirim",
                    isLoading: state == FeedbackState.loading,
                ),
              ],
            ),
          ),
        )
    );
  }
}


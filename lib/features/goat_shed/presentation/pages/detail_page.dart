import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/custom_edit_button.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_background_page.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_shed.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_description.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_suggestion.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_status.dart";
import "package:mbelys/features/goat_shed/presentation/viewmodel/detail_viewmodel.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
import "package:provider/provider.dart";

class DetailPage extends StatelessWidget {
  final String shedId;
  const DetailPage({
    super.key,
    required this.shedId
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<DetailViewModel>(param1: shedId),
      child: const DetailView(),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailViewModel>(
      builder: (context, vm, _) {
        switch (vm.state) {
          case DetailState.initial :
          case DetailState.loading :
            return const DetailBackgroundPage(
                child: Center(
                  child: CircularProgressIndicator(),
                )
            );
          case DetailState.error :
            return DetailBackgroundPage(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        vm.errorMessage ?? "Terjadi Kesalahan",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color: AppColors.color9
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15,),
                      CustomShortButton(
                        buttonText: "Coba lagi",
                        onTap: vm.retry,
                      )
                    ],
                  ),
                )
            );
          case DetailState.success:
            final shed = vm.goatShed;

            if (shed == null) {
              return const DetailBackgroundPage(
                  child: CircularProgressIndicator()
              );
            }
            return SuccessContent(shed: shed,);
        }
      },
    );
  }
}

class SuccessContent extends StatelessWidget {
  final GoatShedEntity shed;
  const SuccessContent({
    super.key,
    required this.shed
  });

  @override
  Widget build(BuildContext context) {
    return DetailBackgroundPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shed.name,
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: AppColors.color9
                ),
              ),
              const CustomEditButton()
            ],
          ),
          const SizedBox(height: 10,),
          DetailGoatShed(
            shed: shed,
          ),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: DetailGoatStatus(),
          ),
          const SizedBox(height: 20,),
          DetailGoatDescription(),
          const SizedBox(height: 20,),
          DetailGoatSuggestion(),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
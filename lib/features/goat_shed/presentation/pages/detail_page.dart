import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/custom_edit_button.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_background_page.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_shed.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_description.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_suggestion.dart";
import "package:mbelys/features/goat_shed/presentation/Widgets/detail_goat_status.dart";
import "package:mbelys/features/goat_shed/presentation/viewmodel/detail_viewmodel.dart";
import "package:mbelys/presentation/widgets/custom_loading.dart";
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
            return DetailBackgroundPage(
              onRefresh: null,
              shedImageUrl: null,
              child: Center(
                child: CustomLoading(),
              )
            );
          case DetailState.error :
            return DetailBackgroundPage(
                onRefresh: null,
                shedImageUrl: null,
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
              return DetailBackgroundPage(
                  onRefresh: null,
                  shedImageUrl: null,
                  child: Center(
                    child: CustomLoading(),
                  )
              );
            }
            return SuccessContent(
              onRefresh: vm.refresh,
              shed: shed,
            );
        }
      },
    );
  }
}

class SuccessContent extends StatelessWidget {
  final GoatShedEntity shed;
  final Future<void> Function()? onRefresh;
  const SuccessContent({
    super.key,
    required this.shed,
    this.onRefresh
  });

  @override
  Widget build(BuildContext context) {
    return DetailBackgroundPage(
      onRefresh: onRefresh,
      shedImageUrl: shed.shedImageUrl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 20,
            children: [
              Expanded(
                child: AutoSizeText(
                  shed.shedName,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: AppColors.color9
                  ),
                  maxLines: 2,
                  minFontSize: 28,
                  maxFontSize: 32,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              CustomEditButton(
                onPressed: () => context.goNamed(
                    RouterName.edit,
                    pathParameters: {"shedId" : shed.shedId}
                ),
              )
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
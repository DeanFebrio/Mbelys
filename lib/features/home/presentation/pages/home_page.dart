import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/home/presentation/viewmodel/home_viewmodel.dart";
import "package:mbelys/features/home/presentation/widgets/card_kandang.dart";
import "package:mbelys/features/home/presentation/widgets/home_app_bar.dart";
import "package:provider/provider.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => sl<HomeViewModel>(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final user = vm.user;

    return SingleChildScrollView(
      child: Column(
        children: [
          HomeAppBar(
            name: user?.name,
          ),
          const SizedBox(height: 10,),
          Text(
            "Daftar Kandang",
            style: TextStyle(
                fontSize: 32,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: AppColors.color9
            ),
          ),
          const SizedBox(height: 20,),
          const CardKandang(),
          const SizedBox(height: 20,),
          const CardKandang(),
          const SizedBox(height: 20,),
          const CardKandang(),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}


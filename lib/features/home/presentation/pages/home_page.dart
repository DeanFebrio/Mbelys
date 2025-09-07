import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/home/presentation/viewmodel/home_viewmodel.dart";
import "package:mbelys/features/home/presentation/widgets/card_goat_shed.dart";
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeAppBar(
            name: user?.name,
          ),
          const SizedBox(height: 10,),
          _buildContent(vm),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }

  Widget _buildContent (HomeViewModel vm) {
    switch (vm.state) {
      case HomeState.initial:
      case HomeState.loading:
        return const Center(child: CircularProgressIndicator(),);
      case HomeState.error:
        return ErrorSection();
      case HomeState.success:
        if (vm.sheds.isEmpty) {
          return NoGoatShed();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Text(
                  "Daftar Kandang",
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: AppColors.color9
                  ),
                ),
                const SizedBox(height: 25,),
                ListView.separated(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.sheds.length,
                  itemBuilder: (context, index) {
                    final shed = vm.sheds[index];
                    return Center(
                      child: CardGoatShed(shed: shed),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 25,),
                ),

              ],
            ),
          );
        }
    }
  }
}

class ErrorSection extends StatelessWidget {
  const ErrorSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/not_found.png",
              height: 180,
              width: 180,
            ),
            Text(
              "Terjadi kesalahan",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color8
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5,),
            Text(
              "Tolong hubungi admin Mbelys untuk informasi lebih lanjut",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600,
                  color: AppColors.color9
              ),
              textAlign: TextAlign.center,
            )
          ]
      ),
    );
  }
}

class NoGoatShed extends StatelessWidget {
  const NoGoatShed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              "assets/images/not_found.png",
            height: 180,
            width: 180,
          ),
          Text(
            "Belum ada kandang terdaftar",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              color: AppColors.color8
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5,),
          Text(
            "Tekan tombol '+' untuk mendaftarkan kandang pertama Anda.",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Mulish",
              fontWeight: FontWeight.w600,
              color: AppColors.color9
            ),
            textAlign: TextAlign.center,
          )
        ]
      ),
    );
  }
}


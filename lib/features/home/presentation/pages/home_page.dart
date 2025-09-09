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

    return RefreshIndicator(
      onRefresh: () => vm.refresh(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: _HomeHeaderDelegate(
                child: HomeAppBar(name: user?.name,),
                minHeight: 220,
                maxHeight: 220
              ),
            ),
            ..._buildContent(vm)
          ]
        ),
      ),
    );
  }

  List<Widget> _buildContent (HomeViewModel vm) {
    switch (vm.state) {
      case HomeState.initial:
      case HomeState.loading:
        return const [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ];
      case HomeState.error:
        return const [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorSection(),
          )
        ];
      case HomeState.success:
        if (vm.sheds.isEmpty) {
          return const [
            SliverFillRemaining(
              hasScrollBody: false,
              child: NoGoatShed(),
            )
          ];
        }
        return [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
                  Text(
                    "Daftar Kandang",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppColors.color9
                    ),
                    textAlign: TextAlign.center,
                  ),
                ])
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final shed = vm.sheds[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == vm.sheds.length - 1 ? 50 : 25,
                    ),
                      child: Center(child: CardGoatShed(shed: shed),),
                  );
                },
                childCount: vm.sheds.length,
              ),
            ),
          )
        ];
    }
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _HomeHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _HomeHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
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
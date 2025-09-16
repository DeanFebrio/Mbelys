import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/features/home/presentation/viewmodel/home_viewmodel.dart";
import "package:mbelys/features/home/presentation/widgets/card_goat_shed.dart";
import "package:mbelys/features/home/presentation/widgets/home_app_bar.dart";
import "package:mbelys/presentation/widgets/custom_short_button.dart";
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
      color: AppColors.color10,
      backgroundColor: AppColors.color3,
      onRefresh: () => vm.refresh(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                pinned: false,
                delegate: _HomeHeaderDelegate(
                  child: HomeAppBar(name: user?.name, profileUrl: user?.photoUrl,),
                  minHeight: 180,
                  maxHeight: 180
                ),
              ),
              ...buildContent(vm),
              const SliverToBoxAdapter(child: SizedBox(height: 24,))
            ]
          ),
        ),
      ),
    );
  }

  List<Widget> buildContent (HomeViewModel vm) {
    return switch (vm.state) {
      HomeState.initial || HomeState.loading => [
        const SliverToBoxAdapter(child: LoadingSection(key: ValueKey('loading'),),)
      ],
      HomeState.error => [
        const SliverToBoxAdapter(child: ErrorSection(key: ValueKey('error'),),)
      ],
      HomeState.success when vm.sheds.isEmpty => [
        const SliverToBoxAdapter(child: NoGoatShed(key: ValueKey('empty'),),)
      ],
      HomeState.success => [
        const TitleSection(text: "Daftar Kandang"),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          sliver: SliverList.separated(
            itemCount: vm.sheds.length,
            separatorBuilder: (_, __) => const SizedBox(height: 25),
            itemBuilder: (context, index) {
              final shed = vm.sheds[index];
              final isLast = index == vm.sheds.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 50 : 0),
                child: Center(child: CardGoatShed(shed: shed),),
              );
            },
          ),
        )
      ]
    };
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

class TitleSection extends StatelessWidget {
  final String text;
  const TitleSection({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: AppColors.color9
          ),
        ),
      ),
    );
  }
}


class LoadingSection extends StatelessWidget {
  const LoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.color12,
        ),
      ),
    );
  }
}


class ErrorSection extends StatelessWidget {
  const ErrorSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/error.png",
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
            const SizedBox(height: 8,),
            Text(
              "Silahkan coba lagi atau hubungi admin Mbelys.",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600,
                  color: AppColors.color9
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15,),
            CustomShortButton(
              buttonText: "Coba Lagi",
              onTap: () => context.read<HomeViewModel>().refresh(),
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
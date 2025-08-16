import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:icons_plus/icons_plus.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";

class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell statefulNavigationShell;

  const MainScaffold({
    super.key,
    required this.statefulNavigationShell
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {

  void _goBranch(int index) {
    widget.statefulNavigationShell.goBranch(
      index,
      initialLocation: index == widget.statefulNavigationShell.currentIndex
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color2,
      body: widget.statefulNavigationShell,

      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: AppColors.color9,
          shape: const CircleBorder(),
          elevation: 0,
          onPressed: () {
            context.go(RouterPath.add);
          },
          child: Icon(
              MingCute.add_line,
              size: 40,
              color: AppColors.color13
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.color13,
          elevation: 1,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      const Icon(MingCute.home_4_line, size: 35,),
                      if (widget.statefulNavigationShell.currentIndex == 0)
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: AppColors.color9,
                          borderRadius: BorderRadius.circular(50)
                        ),
                      )
                    ],
                  ),
                  label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(FontAwesome.user, size: 30,),
                      const SizedBox(height: 3,),
                      if (widget.statefulNavigationShell.currentIndex == 1)
                      Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: AppColors.color9,
                            borderRadius: BorderRadius.circular(50)
                        ),
                      )
                    ],
                  ),
                  label: 'Profil'
              ),
            ],
          currentIndex: widget.statefulNavigationShell.currentIndex,
          selectedItemColor: AppColors.color9,
          unselectedItemColor: AppColors.color12,
          onTap: (index) {
              _goBranch(index);
          },
        ),
      ),
    );
  }
}

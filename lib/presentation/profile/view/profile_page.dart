import "package:flutter/material.dart";
import "package:mbelys/core/services/service_locator.dart";
import "package:mbelys/presentation/profile/viewmodel/profile_viewmodel.dart";
import "package:mbelys/presentation/profile/widgets/card_profile.dart";
import "package:mbelys/presentation/profile/widgets/card_profile_skeleton.dart";
import "package:mbelys/presentation/profile/widgets/contact_container.dart";
import "package:mbelys/presentation/profile/widgets/logout_button.dart";
import "package:mbelys/presentation/profile/widgets/profile_background_page.dart";
import "package:provider/provider.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ProfileViewModel>(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final user = vm.user;

    return ProfileBackgroundPage(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 120,),
            if (user == null)
              const CardProfileSkeleton()
            else
              CardProfile(
                name: user.name,
                email: user.email,
                phone: user.phone,
              ),
            const SizedBox(height: 30,),
            ContactContainer(),
            const SizedBox(height: 80,),
            LogoutButton(
              onPressed: () async => await vm.logout(),
            )
          ],
        ),
      ),
    );
  }
}


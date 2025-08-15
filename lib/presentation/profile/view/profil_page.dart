import "package:flutter/material.dart";
import "package:mbelys/presentation/profile/widgets/card_profil.dart";
import "package:mbelys/presentation/profile/widgets/contact_container.dart";
import "package:mbelys/presentation/profile/widgets/logout_button.dart";
import "package:mbelys/presentation/profile/widgets/profile_background_page.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilBackgroundPage(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CardProfile(),
            const SizedBox(height: 30,),
            ContactContainer(),
            const SizedBox(height: 80,),
            LogoutButton()
          ],
        ),
      ),
    );
  }
}

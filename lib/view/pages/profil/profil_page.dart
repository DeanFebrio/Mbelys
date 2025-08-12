import "package:flutter/material.dart";
import "package:mbelys/view/pages/profil/widgets/card_profil.dart";
import "package:mbelys/view/pages/profil/widgets/contact_container.dart";
import "package:mbelys/view/pages/profil/widgets/logout_button.dart";
import "package:mbelys/view/pages/profil/widgets/profil_background_page.dart";

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ProfilBackgroundPage(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.15,
            ),
            CardProfil(),
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

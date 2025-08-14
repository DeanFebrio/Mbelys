import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/view/pages/profil/profil_page.dart";

class EditSaveButton extends StatelessWidget {
  const EditSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (e) => ProfilPage()),
          );
        },
        style: FilledButton.styleFrom(
            backgroundColor: AppColors.color9,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Text(
          "Simpan",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.color2
          ),
        )
    );
  }
}

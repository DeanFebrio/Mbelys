import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/core/router/router.dart";
import "package:mbelys/features/user/presentation/widgets/custom_contact_button.dart";

class ContactContainer extends StatelessWidget {
  const ContactContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hubungi Kami",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.color9
          ),
        ),
        const SizedBox(height: 10,),
        Card(
          color: AppColors.color6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: 320,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                CustomContactButton(
                  labelText: "Kritik dan Saran",
                  onTap: (){
                    context.push(RouterPath.feedback);
                  },
                ),
                CustomContactButton(
                  labelText: "Whatsapp",
                  onTap: (){},
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

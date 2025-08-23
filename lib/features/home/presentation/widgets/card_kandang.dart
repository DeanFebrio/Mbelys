import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/home/presentation/widgets/label_card_kandang.dart";
import "package:mbelys/presentation/widgets/custom_next_button.dart";

class CardKandang extends StatelessWidget {
  const CardKandang({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.color6,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 320,
        child: Column(
         children: [
           Image.asset(
               "assets/images/kandang.png",
             height: 150,
             width: 320,
             cacheWidth: 320,
             filterQuality: FilterQuality.low,
             fit: BoxFit.cover,
           ),
           Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               spacing: 8,
               children: [
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           LabelCardKandang(
                               textLabel: "Stres",
                               backgroundColor: AppColors.color4
                           ),
                           const SizedBox(width: 8,),
                           LabelCardKandang(
                               textLabel: "Birahi",
                               backgroundColor: AppColors.color5
                           ),
                         ],
                       ),
                       const SizedBox(height: 8,),
                       Text(
                         "Kandang Aaaaaaaaay...",
                         style: TextStyle(
                           fontSize: 24,
                           fontFamily: "Poppins",
                           fontWeight: FontWeight.w700,
                           color: AppColors.color1
                         ),
                         softWrap: true,
                       )
                     ],
                   ),
                 ),
                 const CustomNextButton()
               ],
             ),
           )
         ],
        ),
      )
    );
  }
}

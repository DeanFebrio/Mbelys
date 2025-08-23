import "package:flutter/material.dart";
import "package:icons_plus/icons_plus.dart";
import "package:mbelys/core/constant/app_colors.dart";

class SaranPenanganan extends StatefulWidget {
  const SaranPenanganan({super.key});

  @override
  State<SaranPenanganan> createState() => _SaranPenangananState();
}

class _SaranPenangananState extends State<SaranPenanganan> with
SingleTickerProviderStateMixin {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.color14,
          width: 2
        ),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.color2
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.color6,
                    child: Icon(
                        MingCute.heart_crack_fill,
                      size: 20,
                      color: AppColors.color9,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      "Saran Penanganan",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: AppColors.color9
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ?
                        Icons.keyboard_arrow_right :
                        Icons.keyboard_arrow_right,
                    color: AppColors.color9,
                  )
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCirc,
            child: isExpanded
                ? Padding(
              padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 5,
                  bottom: 15
              ),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w600,
                  color: AppColors.color1,
                ),
                textAlign: TextAlign.justify,
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      )
    );
  }
}

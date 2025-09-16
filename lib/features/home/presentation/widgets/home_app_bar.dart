import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/core/router/router.dart';
import 'package:mbelys/presentation/widgets/custom_avatar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.name,
    this.profileUrl
  });

  final String? name;
  final String? profileUrl;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        padding: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
        width: screenWidth,
        color: AppColors.color9,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: AppColors.color11,
                      ),
                    ),
                    AutoSizeText(
                      name ?? "Peternak",
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: AppColors.color2
                      ),
                      maxLines: 1,
                      softWrap: true,
                      minFontSize: 24,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: (){
                  context.go(RouterPath.profile);
                },
                child: CustomAvatar(photoUrl: profileUrl,)
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

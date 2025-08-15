import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/widgets/custom_back_button.dart";

class DetailBackgroundPage extends StatelessWidget {
  final Widget child;

  const DetailBackgroundPage({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize.height * 0.3,
            width: screenSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/kandang.png",
                  ),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
            top: 50,
              left: 16,
              child: CustomBackButton()
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.color2,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: child,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/presentation/widgets/custom_back_button.dart";
import "package:shimmer/shimmer.dart";

class DetailBackgroundPage extends StatelessWidget {
  final Widget child;
  final String? shedImageUrl;
  final Future<void> Function()? onRefresh;

  const DetailBackgroundPage({
    super.key,
    required this.child,
    this.shedImageUrl,
    this.onRefresh,
  });

  Widget shimmerBox () {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: AppColors.color13,),
      ),
    );
  }

  Widget buildImage () {
    if (shedImageUrl != null && shedImageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: shedImageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => shimmerBox(),
        errorWidget: (context, url, error) => shimmerBox(),
        fadeInDuration: const Duration(milliseconds: 220),
        memCacheHeight: 900,
        memCacheWidth: 1600,
      );
    }
    else {
      return shimmerBox();
    }
  }

  Widget headerImage () {
    final url = shedImageUrl ?? "";
    final img = (url.isEmpty)
        ? const SizedBox.shrink()
        : CachedNetworkImage(
            imageUrl: shedImageUrl!,
            fit: BoxFit.cover,
            placeholder: (context, url) => shimmerBox(),
            errorWidget: (context, url, error) => shimmerBox(),
            fadeInDuration: const Duration(milliseconds: 220),
            memCacheHeight: 900,
            memCacheWidth: 1600,
          );

    return Stack(
      fit: StackFit.expand,
      children: [
        img,
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.black54, Colors.transparent],
              stops: [0.0, 0.55],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: onRefresh ?? () async {},
          color: AppColors.color10,
          backgroundColor: AppColors.color3,
          child: Stack(
            children: [
              SizedBox(
                height: screenSize.height * 0.4,
                width: screenSize.width,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: headerImage()
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: CustomBackButton(),
                )
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.65,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  final scrollable = SingleChildScrollView(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: child,
                    ),
                  );

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.color2,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: scrollable
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart";
import "package:mbelys/features/home/presentation/widgets/label_card_kandang.dart";
import "package:mbelys/features/home/presentation/widgets/card_next_button.dart";
import "package:shimmer/shimmer.dart";

class CardGoatShed extends StatelessWidget {
  final GoatShedEntity shed;

  const CardGoatShed({
    super.key,
    required this.shed
  });

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
              Hero(
                tag: 'shed_image_${shed.shedId}',
                child: ShedImage(url: shed.shedImageUrl,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15),
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
                            shed.shedName,
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
                    CardNextButton(
                      shedId: shed.shedId,
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

class ShedImage extends StatelessWidget {
  final String? url;
  const ShedImage({
    super.key,
    this.url
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16/9,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)
          ),
          child: (url != null && url!.isNotEmpty)
          ? CachedNetworkImage(
            imageUrl: url!,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 200),
            memCacheWidth: 800,
            memCacheHeight: 450,
            placeholder: (context, url) => ShimmerBox(),
            errorWidget: (context, url, error) => Container(
              color: AppColors.color12,
              child: Icon(Icons.error_outline, color: AppColors.color5),
            ),
          ) : ShimmerBox()
        ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.white),
    );
  }
}

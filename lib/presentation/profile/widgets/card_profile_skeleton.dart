import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";
import "package:mbelys/core/constant/app_colors.dart";

class CardProfileSkeleton extends StatelessWidget {
  const CardProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.color13,
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        width: 320,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerBox(width: 120, height: 20),
                  const SizedBox(height: 8),
                  shimmerBox(width: 180, height: 14),
                  const SizedBox(height: 6),
                  shimmerBox(width: 100, height: 14),
                  const SizedBox(height: 16),
                  shimmerBox(width: 80, height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

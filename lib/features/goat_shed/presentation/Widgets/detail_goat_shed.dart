import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart";

class DetailGoatShed extends StatelessWidget {
  final GoatShedEntity shed;
  const DetailGoatShed({
    super.key,
    required this.shed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("🐐"),
            const SizedBox(width: 5,),
            Text(
              "Jumlah Kambing: ",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: AppColors.color1
              ),
            ),
            Text(
              shed.total.toString(),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  color: AppColors.color9
              ),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍"),
            const SizedBox(width: 5,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lokasi:",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: AppColors.color1
                    ),
                  ),
                  Text(
                    shed.location,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        color: AppColors.color9
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

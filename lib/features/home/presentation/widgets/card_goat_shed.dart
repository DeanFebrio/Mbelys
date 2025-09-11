import "package:flutter/material.dart";
import "package:mbelys/core/constant/app_colors.dart";
import "package:mbelys/features/goat_shed/domain/entities/goat_shed_entity.dart";
import "package:mbelys/features/home/presentation/widgets/label_card_kandang.dart";
import "package:mbelys/features/home/presentation/widgets/card_next_button.dart";

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
           _buildShedImage(),
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

  Widget _buildShedImage () {
    if (shed.shedImageUrl != null && shed.shedImageUrl!.isNotEmpty) {
      return Image.network(
        shed.shedImageUrl!,
        height: 150,
        width: 320,
        cacheWidth: 320,
        filterQuality: FilterQuality.low,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            height: 150,
            width: 320,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator(),),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceHolderImage();
        },
      );
    } else {
      return _buildPlaceHolderImage();
    }
  }

  Widget _buildPlaceHolderImage() {
    return Container(
      height: 150,
      width: 320,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_not_supported,
        color: Colors.grey[600],
        size: 50,
      ),
    );
  }
}
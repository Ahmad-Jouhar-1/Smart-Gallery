import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0.hp,
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.mm),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.accentBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.sbr),
      ),
      child: image.startsWith('http')
          ? Image.network(image, fit: BoxFit.cover)
          : Image.asset(image, fit: BoxFit.cover),
    );
  }
}

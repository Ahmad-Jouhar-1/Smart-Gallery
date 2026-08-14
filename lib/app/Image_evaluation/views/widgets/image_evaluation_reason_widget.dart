import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class ImageEvaluationReasonWidget extends StatelessWidget {
  const ImageEvaluationReasonWidget({super.key, required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0.hp,
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.mm),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.transparentPrimaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.sbr),
      ),
      child: Text(
        reason,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: AppDimensions.mfs,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

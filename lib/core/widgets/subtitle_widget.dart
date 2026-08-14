import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      child: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.accentTextColor,
          fontSize: AppDimensions.mfs,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

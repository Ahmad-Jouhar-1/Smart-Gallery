import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PeopleEmptyWidget extends StatelessWidget {
  const PeopleEmptyWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppDimensions.xlp),
      children: [
        Image.asset(image),
        SizedBox(height: AppDimensions.mp),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppDimensions.lfs,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimensions.mp),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.accentTextColor,
            fontSize: AppDimensions.sfs,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

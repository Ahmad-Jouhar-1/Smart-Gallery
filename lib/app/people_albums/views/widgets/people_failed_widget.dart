import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PeopleFailedWidget extends StatelessWidget {
  const PeopleFailedWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTryAgain,
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTryAgain;

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
        SizedBox(height: AppDimensions.lp),
        GestureDetector(
          onTap: onTryAgain,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.mbr),
            ),
            alignment: Alignment.center,
            child: Text(
              'Try Again',
              style: TextStyle(
                color: AppColors.foregroundColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

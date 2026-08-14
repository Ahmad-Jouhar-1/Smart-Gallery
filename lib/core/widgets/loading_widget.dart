import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: AppColors.primaryColor,
        rightDotColor: AppColors.secondaryColor,
        size: AppDimensions.lis,
      ),
    );
  }
}

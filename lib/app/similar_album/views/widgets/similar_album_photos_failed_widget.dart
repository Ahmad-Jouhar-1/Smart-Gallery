import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SimilarAlbumPhotosFailedWidget extends StatelessWidget {
  const SimilarAlbumPhotosFailedWidget({
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
        _FailedImageWidget(image: image),

        SizedBox(height: AppDimensions.mp),

        _FailedTitleWidget(title: title),

        SizedBox(height: AppDimensions.mp),

        _FailedSubtitleWidget(subtitle: subtitle),

        SizedBox(height: AppDimensions.lp),

        _TryAgainButtonWidget(onTap: onTryAgain),
      ],
    );
  }
}

class _FailedImageWidget extends StatelessWidget {
  const _FailedImageWidget({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}

class _FailedTitleWidget extends StatelessWidget {
  const _FailedTitleWidget({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: AppDimensions.lfs,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _FailedSubtitleWidget extends StatelessWidget {
  const _FailedSubtitleWidget({required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.accentTextColor,
        fontSize: AppDimensions.sfs,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _TryAgainButtonWidget extends StatelessWidget {
  const _TryAgainButtonWidget({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}

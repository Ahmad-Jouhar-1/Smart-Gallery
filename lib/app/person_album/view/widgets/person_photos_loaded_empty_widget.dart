import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PersonPhotosLoadedEmptyWidget extends StatelessWidget {
  const PersonPhotosLoadedEmptyWidget({
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
        _LoadedEmptyImageWidget(image: image),

        SizedBox(height: AppDimensions.mp),

        _LoadedEmptyTitleWidget(title: title),

        SizedBox(height: AppDimensions.mp),

        _LoadedEmptySubtitleWidget(subtitle: subtitle),
      ],
    );
  }
}

class _LoadedEmptyImageWidget extends StatelessWidget {
  const _LoadedEmptyImageWidget({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}

class _LoadedEmptyTitleWidget extends StatelessWidget {
  const _LoadedEmptyTitleWidget({required this.title});

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

class _LoadedEmptySubtitleWidget extends StatelessWidget {
  const _LoadedEmptySubtitleWidget({required this.subtitle});

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

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class ImageEvaluationScoreWidget extends StatelessWidget {
  const ImageEvaluationScoreWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.score,
    required this.level,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final int score;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0.hp,
      margin: EdgeInsets.symmetric(horizontal: AppDimensions.mm),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      decoration: BoxDecoration(
        color: AppColors.accentBackgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.sbr),
      ),
      child: Row(
        children: [
          _ScoreInfoWidget(icon: icon, title: title, subtitle: subtitle),

          SizedBox(width: AppDimensions.mp),

          _ScoreIndicatorWidget(score: score, level: level),
        ],
      ),
    );
  }
}

class _ScoreInfoWidget extends StatelessWidget {
  const _ScoreInfoWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          _ScoreIconWidget(icon: icon),

          SizedBox(width: AppDimensions.sp),

          _ScoreTextsWidget(title: title, subtitle: subtitle),
        ],
      ),
    );
  }
}

class _ScoreIconWidget extends StatelessWidget {
  const _ScoreIconWidget({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.lis,
      height: AppDimensions.lis,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.transparentPrimaryColor,
      ),
      child: Icon(icon, color: AppColors.primaryColor, size: AppDimensions.sis),
    );
  }
}

class _ScoreTextsWidget extends StatelessWidget {
  const _ScoreTextsWidget({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppDimensions.mfs,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: AppDimensions.sp / 2),

          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.accentTextColor,
              fontSize: AppDimensions.sfs,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreIndicatorWidget extends StatelessWidget {
  const _ScoreIndicatorWidget({required this.score, required this.level});
  final int score;
  final String level;

  @override
  Widget build(BuildContext context) {
    Color specifyProgressColor() {
      switch (level) {
        case "High":
          return Colors.green;
        case "Medium":
          return Colors.orange;
        case "Low":
          return Colors.red;
        default:
          return AppColors.primaryColor;
      }
    }

    return CircularPercentIndicator(
      radius: 8.0.wp,
      lineWidth: 1.5.wp,
      percent: score / 100,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: AppColors.transparentPrimaryColor,
      progressColor: specifyProgressColor(),
      center: Text(
        score.toString(),
        style: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.lfs,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

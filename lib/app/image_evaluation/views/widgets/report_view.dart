import 'package:flutter/material.dart';
import 'package:smart_gallery/app/image_evaluation/models/report_model.dart';
import 'package:smart_gallery/app/image_evaluation/views/widgets/photo_widget.dart';
import 'package:smart_gallery/app/image_evaluation/views/widgets/reason_widget.dart';
import 'package:smart_gallery/app/image_evaluation/views/widgets/score_widget.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class ReportView extends StatelessWidget {
  const ReportView({
    super.key,
    required this.photo,
    required this.report,
  });

  final PhotoModel photo;
  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        PhotoWidget(image: photo.image),
        SizedBox(height: AppDimensions.mp),
        ScoreWidget(
          icon: Icons.light_mode_outlined,
          title: "Lighting",
          subtitle: "Brightness and exposure quality",
          score: report.lightingScore,
          level: report.lightingLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ScoreWidget(
          icon: Icons.center_focus_strong_outlined,
          title: "Clarity",
          subtitle: "Image detail and visual clarity",
          score: report.clarityScore,
          level: report.clarityLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ScoreWidget(
          icon: Icons.accessibility_new_outlined,
          title: "Body Position",
          subtitle: "Pose and body alignment",
          score: report.bodyPositionScore,
          level: report.bodyPositionLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ScoreWidget(
          icon: Icons.visibility_outlined,
          title: "Eye Openness",
          subtitle: "How clearly the eyes are open",
          score: report.eyeOpenScore,
          level: report.eyeOpenLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ScoreWidget(
          icon: Icons.auto_awesome_outlined,
          title: "Overall Score",
          subtitle: "Combined image quality result",
          score: report.finalScore,
          level: report.finalLevel,
        ),
        SizedBox(height: AppDimensions.mp),
        ReasonWidget(reason: report.finalReason),
      ],
    );
  }
}

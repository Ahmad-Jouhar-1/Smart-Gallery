import 'package:flutter/material.dart';
import 'package:smart_gallery/app/Image_evaluation/models/image_evaluation_model.dart';
import 'package:smart_gallery/app/Image_evaluation/views/widgets/Image_evaluation_reason_widget.dart';
import 'package:smart_gallery/app/Image_evaluation/views/widgets/Image_evaluation_score_widget.dart';
import 'package:smart_gallery/app/Image_evaluation/views/widgets/image_evaluation_photo_widget.dart';
import 'package:smart_gallery/app/similar_album/models/similar_album_photo_model.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class ImageEvaluationLoadedWidget extends StatelessWidget {
  const ImageEvaluationLoadedWidget({
    super.key,
    required this.similarAlbumPhoto,
    required this.imageEvaluation,
  });
  final SimilarAlbumPhotoModel similarAlbumPhoto;
  final ImageEvaluationModel imageEvaluation;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        ImageEvaluationPhotoWidget(image: similarAlbumPhoto.image),
        SizedBox(height: AppDimensions.mp),
        ImageEvaluationScoreWidget(
          icon: Icons.light_mode_outlined,
          title: "Lighting",
          subtitle: "Brightness and exposure quality",
          score: imageEvaluation.lightingScore,
          level: imageEvaluation.lightingLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ImageEvaluationScoreWidget(
          icon: Icons.blur_on_outlined,
          title: "Sharpness",
          subtitle: "Clarity and motion blur level",
          score: imageEvaluation.blurScore,
          level: imageEvaluation.blurLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ImageEvaluationScoreWidget(
          icon: Icons.accessibility_new_outlined,
          title: "Body Position",
          subtitle: "Pose and body alignment",
          score: imageEvaluation.bodyPositionScore,
          level: imageEvaluation.bodyPositionLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ImageEvaluationScoreWidget(
          icon: Icons.visibility_outlined,
          title: "Eye Openness",
          subtitle: "How clearly the eyes are open",
          score: imageEvaluation.eyeOpenScore,
          level: imageEvaluation.eyeOpenLevel,
        ),
        SizedBox(height: AppDimensions.sp),
        ImageEvaluationScoreWidget(
          icon: Icons.auto_awesome_outlined,
          title: "Overall Score",
          subtitle: "Combined image quality result",
          score: imageEvaluation.finalScore,
          level: imageEvaluation.finalLevel,
        ),
        SizedBox(height: AppDimensions.mp),
        ImageEvaluationReasonWidget(reason: imageEvaluation.finalReason),
      ],
    );
  }
}

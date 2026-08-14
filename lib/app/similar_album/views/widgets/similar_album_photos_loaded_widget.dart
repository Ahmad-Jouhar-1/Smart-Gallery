import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smart_gallery/app/Image_evaluation/views/screens/image_evaluation_screen.dart';
import 'package:smart_gallery/app/similar_album/models/similar_album_photo_model.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_best_photo_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photos_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SimilarAlbumPhotosLoadedWidget extends StatelessWidget {
  const SimilarAlbumPhotosLoadedWidget({
    super.key,
    required this.similarAlbumBestPhoto,
    required this.similarAlbumPhotos,
  });
  final SimilarAlbumPhotoModel similarAlbumBestPhoto;
  final List<SimilarAlbumPhotoModel> similarAlbumPhotos;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        SimilarAlbumBestPhotoWidget(
          similarAlbumPhoto: similarAlbumBestPhoto,
          onTap:
              () => Get.to(
                ImageEvaluationScreen(similarAlbumPhoto: similarAlbumBestPhoto),
                transition: Transition.circularReveal,
              ),
        ),
        SizedBox(height: AppDimensions.mp),
        SimilarAlbumPhotosWidget(similarAlbumPhotos: similarAlbumPhotos),
      ],
    );
  }
}

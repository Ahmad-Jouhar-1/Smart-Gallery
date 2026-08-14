import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/Image_evaluation/views/screens/image_evaluation_screen.dart';
import 'package:smart_gallery/app/similar_album/models/similar_album_photo_model.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photo_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SimilarAlbumPhotosWidget extends StatelessWidget {
  const SimilarAlbumPhotosWidget({super.key, required this.similarAlbumPhotos});
  final List<SimilarAlbumPhotoModel> similarAlbumPhotos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: similarAlbumPhotos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.sp,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return SimilarAlbumPhotoWidget(
          similarAlbumPhoto: similarAlbumPhotos[index],
          onTap:
              () => Get.to(
                ImageEvaluationScreen(
                  similarAlbumPhoto: similarAlbumPhotos[index],
                ),
                transition: Transition.circularReveal,
              ),
        );
      },
    );
  }
}

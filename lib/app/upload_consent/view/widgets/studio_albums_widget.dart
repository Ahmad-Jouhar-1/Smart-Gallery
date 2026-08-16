import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/upload_consent/models/studio_album_model.dart';
import 'package:smart_gallery/app/upload_consent/view/screens/album_analysis_screen.dart';
import 'package:smart_gallery/app/upload_consent/view/widgets/studio_album_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class StudioAlbumsWidget extends StatelessWidget {
  const StudioAlbumsWidget({super.key, required this.studioAlbums});

  final List<StudioAlbumModel> studioAlbums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: studioAlbums.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.mp,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final album = studioAlbums[index];

        return StudioAlbumWidget(
          album: album,
          onTap: () => Get.to(
            () => AlbumAnalysisScreen(album: album),
            transition: Transition.circularReveal,
          ),
        );
      },
    );
  }
}

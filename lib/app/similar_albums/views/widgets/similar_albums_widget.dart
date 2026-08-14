import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smart_gallery/app/similar_album/views/screens/similar_album_screen.dart';
import 'package:smart_gallery/app/similar_albums/models/similar_album_model.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/similar_album_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SimilarAlbumsWidget extends StatelessWidget {
  const SimilarAlbumsWidget({super.key, required this.similarAlbums});
  final List<SimilarAlbumModel> similarAlbums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: similarAlbums.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.mp,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return SimilarAlbumWidget(
          album: similarAlbums[index],
          onTap:
              () => Get.to(
                () => SimilarAlbumScreen(similarAlbum: similarAlbums[index]),
                transition: Transition.circularReveal,
              ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smart_gallery/app/upload_consent/view/screens/album_analysis_screen.dart';
import 'package:smart_gallery/app/upload_consent/view/widgets/studio_album_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class StudioAlbumsWidget extends StatelessWidget {
  const StudioAlbumsWidget({super.key, required this.studioAlbums});

  final List<AssetPathEntity> studioAlbums;

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
          onTap: () => _confirmAnalysis(context, album),
        );
      },
    );
  }

  void _confirmAnalysis(BuildContext context, AssetPathEntity album) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.accentBackgroundColor,
        title: Text(
          "Analyze Album",
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppDimensions.lfs,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Analysis for "${album.name}" will start now. Do you want to continue?',
          style: TextStyle(
            color: AppColors.accentTextColor,
            fontSize: AppDimensions.mfs,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColors.accentTextColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Get.to(
                () => AlbumAnalysisScreen(album: album),
                transition: Transition.circularReveal,
              );
            },
            child: Text(
              "Agree",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

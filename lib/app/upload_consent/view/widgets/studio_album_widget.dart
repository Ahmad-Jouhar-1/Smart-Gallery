import 'package:flutter/material.dart';
import 'package:smart_gallery/app/upload_consent/models/studio_album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class StudioAlbumWidget extends StatelessWidget {
  const StudioAlbumWidget({super.key, required this.album, required this.onTap});

  final StudioAlbumModel album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimensions.sp,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.sbr),
              child: SizedBox.expand(
                child: Image.asset(album.image, fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            album.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppDimensions.sfs,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${album.count} Photos',
            maxLines: 1,
            style: TextStyle(
              color: AppColors.accentTextColor,
              fontSize: AppDimensions.sfs,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class StudioAlbumWidget extends StatelessWidget {
  const StudioAlbumWidget({super.key, required this.album, required this.onTap});

  final AssetPathEntity album;
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
              child: SizedBox.expand(child: _AlbumCoverImage(album: album)),
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
          FutureBuilder<int>(
            future: album.assetCountAsync,
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data ?? 0} Photos',
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.accentTextColor,
                  fontSize: AppDimensions.sfs,
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AlbumCoverImage extends StatelessWidget {
  const _AlbumCoverImage({required this.album});

  final AssetPathEntity album;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AssetEntity>>(
      future: album.getAssetListRange(start: 0, end: 1),
      builder: (context, snapshot) {
        final cover = snapshot.data?.firstOrNull;

        if (cover == null) {
          return Container(color: AppColors.transparentPrimaryColor);
        }

        return FutureBuilder<Uint8List?>(
          future: cover.thumbnailDataWithSize(
            const ThumbnailSize.square(200),
          ),
          builder: (context, thumbSnapshot) {
            final bytes = thumbSnapshot.data;

            if (bytes == null) {
              return Container(color: AppColors.transparentPrimaryColor);
            }

            return Image.memory(bytes, fit: BoxFit.cover);
          },
        );
      },
    );
  }
}

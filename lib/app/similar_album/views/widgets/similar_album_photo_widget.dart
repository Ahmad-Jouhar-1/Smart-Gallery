import 'package:flutter/material.dart';
import 'package:smart_gallery/app/similar_album/models/similar_album_photo_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SimilarAlbumPhotoWidget extends StatelessWidget {
  const SimilarAlbumPhotoWidget({
    super.key,
    required this.similarAlbumPhoto,
    required this.onTap,
  });

  final SimilarAlbumPhotoModel similarAlbumPhoto;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.accentBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.sbr),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _Photo(image: similarAlbumPhoto.image),
            _Rate(rate: similarAlbumPhoto.rate),
          ],
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, fit: BoxFit.cover);
  }
}

class _Rate extends StatelessWidget {
  const _Rate({required this.rate});
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppDimensions.sp,
      right: AppDimensions.sp,
      child: Container(
        width: AppDimensions.lis,
        height: AppDimensions.lis,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.transparentBlackColor,
        ),
        child: Text(
          rate.toString(),
          style: TextStyle(
            color: AppColors.foregroundColor,
            fontSize: AppDimensions.sfs,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

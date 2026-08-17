import 'package:flutter/material.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class BestPhotoWidget extends StatelessWidget {
  const BestPhotoWidget({
    super.key,
    required this.photo,
    required this.onTap,
  });

  final PersonPhotoModel photo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25.0.hp,
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.mm),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.accentBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.sbr),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _Photo(image: photo.image),
            _BestBadge(),
            _Rate(rate: photo.rate),
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
    return image.startsWith('http')
        ? Image.network(image, fit: BoxFit.cover)
        : Image.asset(image, fit: BoxFit.cover);
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
          color: AppColors.transparentAccentColor,
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

class _BestBadge extends StatelessWidget {
  const _BestBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppDimensions.sp,
      left: AppDimensions.sp,
      child: Container(
        height: AppDimensions.lis,
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.sp),
        decoration: BoxDecoration(
          color: AppColors.transparentAccentColor,
          borderRadius: BorderRadius.circular(AppDimensions.lbr),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppDimensions.sp,
          children: [
            Icon(
              Icons.star_border_rounded,
              color: AppColors.foregroundColor,
              size: AppDimensions.sis,
            ),
            Text(
              "Best Photo",
              style: TextStyle(
                color: AppColors.foregroundColor,
                fontSize: AppDimensions.sfs,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

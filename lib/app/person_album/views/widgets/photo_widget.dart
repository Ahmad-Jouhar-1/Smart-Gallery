import 'package:flutter/material.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.photo,
    required this.onTap,
    required this.onLongPress,
    required this.isSelecting,
    required this.isSelected,
  });

  final PersonPhotoModel photo;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isSelecting;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.accentBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.sbr),
          border: isSelecting && isSelected
              ? Border.all(color: AppColors.primaryColor, width: 3)
              : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: isSelecting && !isSelected ? 0.55 : 1,
              child: _Photo(image: photo.image),
            ),
            if (isSelecting)
              _SelectionCheck(isSelected: isSelected)
            else
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

class _SelectionCheck extends StatelessWidget {
  const _SelectionCheck({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDimensions.sp,
      left: AppDimensions.sp,
      child: Container(
        width: AppDimensions.mis,
        height: AppDimensions.mis,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.transparentBlackColor,
          border: Border.all(color: AppColors.foregroundColor, width: 1.5),
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: AppColors.foregroundColor,
                size: AppDimensions.mfs,
              )
            : null,
      ),
    );
  }
}

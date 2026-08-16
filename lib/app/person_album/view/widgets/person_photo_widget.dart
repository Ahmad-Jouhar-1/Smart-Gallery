import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PersonPhotoWidget extends StatelessWidget {
  const PersonPhotoWidget({
    super.key,
    required this.image,
    required this.rate,
    required this.onTap,
    required this.onLongPress,
    this.isSelecting = false,
    this.isSelected = false,
    this.isBest = false,
  });

  final String image;
  final int rate;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isSelecting;
  final bool isSelected;
  final bool isBest;

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
              child: _Photo(image: image),
            ),
            if (isBest) _BestBadge(),
            if (isSelecting)
              _SelectionCheck(isSelected: isSelected)
            else
              _Rate(rate: rate),
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

class _BestBadge extends StatelessWidget {
  const _BestBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDimensions.sp,
      right: AppDimensions.sp,
      child: Container(
        height: AppDimensions.lis,
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.sp),
        decoration: BoxDecoration(
          color: AppColors.transparentAccentColor,
          borderRadius: BorderRadius.circular(AppDimensions.lbr),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppDimensions.sm / 2,
          children: [
            Icon(
              Icons.star_border_rounded,
              color: AppColors.foregroundColor,
              size: AppDimensions.sfs,
            ),
            Text(
              "Best",
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

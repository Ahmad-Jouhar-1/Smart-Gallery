import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class ShareBarWidget extends StatelessWidget {
  const ShareBarWidget({
    super.key,
    required this.selectedCount,
    required this.onCancel,
    required this.onShare,
  });

  final int selectedCount;
  final VoidCallback onCancel;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.mp,
        vertical: AppDimensions.sp,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: onCancel,
              child: Icon(Icons.close, color: AppColors.accentTextColor),
            ),

            SizedBox(width: AppDimensions.mp),

            Text(
              "$selectedCount Selected",
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.w600,
              ),
            ),

            Spacer(),

            GestureDetector(
              onTap: selectedCount == 0 ? null : onShare,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.mp,
                  vertical: AppDimensions.sp,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.mbr),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.sm / 2,
                  children: [
                    Icon(
                      Icons.share,
                      color: AppColors.foregroundColor,
                      size: AppDimensions.mfs,
                    ),
                    Text(
                      "Share",
                      style: TextStyle(
                        color: AppColors.foregroundColor,
                        fontSize: AppDimensions.mfs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

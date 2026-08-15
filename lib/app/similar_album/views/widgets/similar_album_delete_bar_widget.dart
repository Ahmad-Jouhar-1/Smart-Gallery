import 'package:flutter/material.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class SimilarAlbumDeleteBarWidget extends StatelessWidget {
  const SimilarAlbumDeleteBarWidget({
    super.key,
    required this.selectedCount,
    required this.onCancel,
    required this.onDelete,
  });

  final int selectedCount;
  final VoidCallback onCancel;
  final VoidCallback onDelete;

  static const Color _deleteColor = Color(0xFFE53935);

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
              onTap: selectedCount == 0
                  ? null
                  : () => _confirmDelete(context),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.mp,
                  vertical: AppDimensions.sp,
                ),
                decoration: BoxDecoration(
                  color: _deleteColor,
                  borderRadius: BorderRadius.circular(AppDimensions.mbr),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppDimensions.sm / 2,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: AppColors.foregroundColor,
                      size: AppDimensions.mfs,
                    ),
                    Text(
                      "Delete",
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

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.accentBackgroundColor,
        title: Text(
          "Delete Photos",
          style: TextStyle(
            color: AppColors.primaryTextColor,
            fontSize: AppDimensions.lfs,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Delete $selectedCount photo${selectedCount == 1 ? '' : 's'}? This cannot be undone.",
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
              onDelete();
            },
            child: Text(
              "Delete",
              style: TextStyle(
                color: _deleteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

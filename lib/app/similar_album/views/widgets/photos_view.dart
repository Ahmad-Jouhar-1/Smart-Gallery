import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:smart_gallery/app/image_evaluation/views/screens/report_screen.dart';
import 'package:smart_gallery/app/similar_album/models/cluster_model.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/best_photo_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/photos_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';

class PhotosView extends StatelessWidget {
  const PhotosView({
    super.key,
    required this.cluster,
    required this.isSelecting,
    required this.selectedIds,
    required this.onStartSelecting,
    required this.onToggleSelected,
    required this.onSelectSuggested,
  });

  final ClusterModel cluster;
  final bool isSelecting;
  final Set<int> selectedIds;
  final ValueChanged<int> onStartSelecting;
  final ValueChanged<int> onToggleSelected;
  final VoidCallback onSelectSuggested;

  @override
  Widget build(BuildContext context) {
    final hasPhotosToReview = cluster.photos.any(
      (photo) => photo.id != cluster.bestPhoto.id,
    );

    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        BestPhotoWidget(
          photo: cluster.bestPhoto,
          onTap: () {
            Get.to(
              () => ReportScreen(photo: cluster.bestPhoto),
              transition: Transition.circularReveal,
            );
          },
        ),
        SizedBox(height: AppDimensions.mp),
        PhotosWidget(
          photos: cluster.photos,
          isSelecting: isSelecting,
          selectedIds: selectedIds,
          onStartSelecting: onStartSelecting,
          onToggleSelected: onToggleSelected,
        ),
        if (hasPhotosToReview && !isSelecting) ...[
          SizedBox(height: AppDimensions.mp),
          _SuggestedButton(onTap: onSelectSuggested),
        ],
        if (isSelecting) SizedBox(height: 12.0.wp),
      ],
    );
  }
}

class _SuggestedButton extends StatelessWidget {
  const _SuggestedButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
        padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
        decoration: BoxDecoration(
          color: AppColors.accentBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.mbr),
          border: Border.all(
            color: AppColors.hintTextColor.withValues(alpha: 0.3),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppDimensions.sm,
          children: [
            Icon(
              Icons.delete_sweep_outlined,
              color: AppColors.accentTextColor,
              size: AppDimensions.mfs,
            ),
            Text(
              "Delete All Except Best",
              style: TextStyle(
                color: AppColors.accentTextColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

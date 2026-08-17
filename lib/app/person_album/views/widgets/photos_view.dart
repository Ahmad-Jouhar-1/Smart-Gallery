import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/image_evaluation/views/screens/report_screen.dart';
import 'package:smart_gallery/app/person_album/models/date_filter.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/app/person_album/views/widgets/best_photo_widget.dart';
import 'package:smart_gallery/app/person_album/views/widgets/date_filter_widget.dart';
import 'package:smart_gallery/app/person_album/views/widgets/photos_widget.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class PhotosView extends StatelessWidget {
  const PhotosView({
    super.key,
    required this.bestPhoto,
    required this.photos,
    required this.filter,
    required this.hasPhotos,
    required this.isSelecting,
    required this.selectedIds,
    required this.onFilterSelected,
    required this.onStartSelecting,
    required this.onToggleSelected,
  });

  final PersonPhotoModel bestPhoto;
  final List<PersonPhotoModel> photos;
  final DateFilter filter;
  final bool hasPhotos;
  final bool isSelecting;
  final Set<int> selectedIds;
  final ValueChanged<DateFilter> onFilterSelected;
  final ValueChanged<int> onStartSelecting;
  final ValueChanged<int> onToggleSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        BestPhotoWidget(
          photo: bestPhoto,
          onTap: () {
            Get.to(
              () => ReportScreen(photo: _toPhoto(bestPhoto)),
              transition: Transition.circularReveal,
            );
          },
        ),
        SizedBox(height: AppDimensions.mp),
        DateFilterWidget(filter: filter, onSelected: onFilterSelected),
        SizedBox(height: AppDimensions.mp),
        SubtitleWidget(subtitle: "${photos.length} Photos"),
        SizedBox(height: AppDimensions.mp),
        if (photos.isEmpty)
          _EmptyPhotos(
            title: hasPhotos ? "No Results" : "No Photos Found",
            subtitle: hasPhotos
                ? "There are no photos captured within this time range."
                : "Capture new moments or upload your favourite images.",
          )
        else
          PhotosWidget(
            photos: photos,
            isSelecting: isSelecting,
            selectedIds: selectedIds,
            onStartSelecting: onStartSelecting,
            onToggleSelected: onToggleSelected,
          ),
        if (isSelecting) SizedBox(height: 12.0.wp),
      ],
    );
  }

  PhotoModel _toPhoto(PersonPhotoModel photo) {
    return PhotoModel(
      id: photo.id,
      image: photo.image,
      rate: photo.rate,
      isSelected: photo.isSelected,
    );
  }
}

class _EmptyPhotos extends StatelessWidget {
  const _EmptyPhotos({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.xlp),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: AppDimensions.mfs,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppDimensions.sp),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.accentTextColor,
              fontSize: AppDimensions.sfs,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

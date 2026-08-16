import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_date_filter.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/app/person_album/view/widgets/person_best_photo_widget.dart';
import 'package:smart_gallery/app/person_album/view/widgets/person_photo_date_filter_widget.dart';
import 'package:smart_gallery/app/person_album/view/widgets/person_photos_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';
import 'package:smart_gallery/app/image_evaluation/views/screens/report_screen.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';

class PersonPhotosLoadedWidget extends StatelessWidget {
  const PersonPhotosLoadedWidget({
    super.key,
    required this.personBestPhoto,
    required this.personPhotos,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.isSelecting,
    required this.selectedIds,
    required this.onStartSelecting,
    required this.onToggleSelected,
  });

  final PersonPhotoModel personBestPhoto;
  final List<PersonPhotoModel> personPhotos;
  final PersonPhotoDateFilter selectedFilter;
  final ValueChanged<PersonPhotoDateFilter> onFilterSelected;
  final bool isSelecting;
  final Set<int> selectedIds;
  final ValueChanged<int> onStartSelecting;
  final ValueChanged<int> onToggleSelected;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        PersonBestPhotoWidget(
          personPhoto: personBestPhoto,
          onTap: () => Get.to(
            () => ReportScreen(
              photo: PhotoModel(
                id: personBestPhoto.id,
                image: personBestPhoto.image,
                rate: personBestPhoto.rate,
                isSelected: false,
              ),
            ),
            transition: Transition.circularReveal,
          ),
        ),

        SizedBox(height: AppDimensions.mp),

        PersonPhotoDateFilterWidget(
          selectedFilter: selectedFilter,
          onFilterSelected: onFilterSelected,
        ),

        SizedBox(height: AppDimensions.mp),

        SubtitleWidget(subtitle: "${personPhotos.length} Photos"),

        SizedBox(height: AppDimensions.mp),

        PersonPhotosWidget(
          personPhotos: personPhotos,
          isSelecting: isSelecting,
          selectedIds: selectedIds,
          onStartSelecting: onStartSelecting,
          onToggleSelected: onToggleSelected,
        ),

        if (isSelecting) SizedBox(height: 12.0.wp),
      ],
    );
  }
}

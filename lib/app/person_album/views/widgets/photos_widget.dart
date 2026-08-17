import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/image_evaluation/views/screens/report_screen.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/app/person_album/views/widgets/photo_widget.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PhotosWidget extends StatelessWidget {
  const PhotosWidget({
    super.key,
    required this.photos,
    required this.isSelecting,
    required this.selectedIds,
    required this.onStartSelecting,
    required this.onToggleSelected,
  });

  final List<PersonPhotoModel> photos;
  final bool isSelecting;
  final Set<int> selectedIds;
  final ValueChanged<int> onStartSelecting;
  final ValueChanged<int> onToggleSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.sp,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final photo = photos[index];
        final isSelected = selectedIds.contains(photo.id);

        return PhotoWidget(
          photo: photo,
          isSelecting: isSelecting,
          isSelected: isSelected,
          onLongPress: () => onStartSelecting(photo.id),
          onTap: () {
            if (isSelecting) {
              onToggleSelected(photo.id);
              return;
            }

            Get.to(
              () => ReportScreen(photo: _toPhoto(photo)),
              transition: Transition.circularReveal,
            );
          },
        );
      },
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

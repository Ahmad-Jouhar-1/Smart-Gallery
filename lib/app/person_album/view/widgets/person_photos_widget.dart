import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/app/person_album/view/widgets/person_photo_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/app/image_evaluation/views/screens/report_screen.dart';

class PersonPhotosWidget extends StatelessWidget {
  const PersonPhotosWidget({
    super.key,
    required this.personPhotos,
    required this.isSelecting,
    required this.selectedIds,
    required this.onStartSelecting,
    required this.onToggleSelected,
  });

  final List<PersonPhotoModel> personPhotos;
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
      itemCount: personPhotos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.sp,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final photo = personPhotos[index];
        final isSelected = selectedIds.contains(photo.id);

        return PersonPhotoWidget(
          image: photo.image,
          rate: photo.rate,
          isSelecting: isSelecting,
          isSelected: isSelected,
          onLongPress: () => onStartSelecting(photo.id),
          onTap: () {
            if (isSelecting) {
              onToggleSelected(photo.id);
              return;
            }

            Get.to(
              () => ReportScreen(
                photo: PhotoModel(
                  id: photo.id,
                  image: photo.image,
                  rate: photo.rate,
                  isSelected: false,
                ),
              ),
              transition: Transition.circularReveal,
            );
          },
        );
      },
    );
  }
}

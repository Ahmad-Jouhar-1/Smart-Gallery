import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:smart_gallery/app/people_albums/controllers/fetch_person_albums/fetch_person_albums_bloc.dart';
import 'package:smart_gallery/app/people_albums/models/person_album_model.dart';
import 'package:smart_gallery/app/person_album/view/screens/person_album_screen.dart';
import 'package:smart_gallery/app/people_albums/view/widgets/person_album_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PersonAlbumsWidget extends StatelessWidget {
  const PersonAlbumsWidget({
    super.key,
    required this.personAlbums,
    required this.isSelecting,
    required this.selectedIds,
    required this.onStartSelecting,
    required this.onToggleSelected,
  });

  final List<PersonAlbumModel> personAlbums;
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
      itemCount: personAlbums.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.mp,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final person = personAlbums[index];
        final isSelected = selectedIds.contains(person.id);

        return PersonAlbumWidget(
          person: person,
          isSelecting: isSelecting,
          isSelected: isSelected,
          onLongPress: () => onStartSelecting(person.id),
          onRename: (newName) => context.read<FetchPersonAlbumsBloc>().add(
            RenamePersonAlbum(id: person.id, newName: newName),
          ),
          onTap: () {
            if (isSelecting) {
              onToggleSelected(person.id);
              return;
            }

            Get.to(
              () => PersonAlbumScreen(person: person),
              transition: Transition.circularReveal,
            );
          },
        );
      },
    );
  }
}

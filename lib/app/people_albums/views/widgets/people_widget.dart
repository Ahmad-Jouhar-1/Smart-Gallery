import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:smart_gallery/app/people_albums/controllers/rename_person_bloc/rename_person_bloc.dart';
import 'package:smart_gallery/app/people_albums/models/person_model.dart';
import 'package:smart_gallery/app/people_albums/views/widgets/person_widget.dart';
import 'package:smart_gallery/app/person_album/views/screens/person_album_screen.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({
    super.key,
    required this.people,
    required this.isSelecting,
    required this.selectedIds,
    required this.onStartSelecting,
    required this.onToggleSelected,
  });

  final List<PersonModel> people;
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
      itemCount: people.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.mp,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final person = people[index];
        final isSelected = selectedIds.contains(person.id);

        return BlocBuilder<RenamePersonBloc, RenamePersonState>(
          buildWhen: (previous, current) {
            final previousId = previous is RenamePersonLoading
                ? previous.personId
                : null;
            final currentId = current is RenamePersonLoading
                ? current.personId
                : null;
            return previousId == person.id || currentId == person.id;
          },
          builder: (context, state) {
            return PersonWidget(
              person: person,
              isSelecting: isSelecting,
              isSelected: isSelected,
              isRenaming:
                  state is RenamePersonLoading && state.personId == person.id,
              onLongPress: () => onStartSelecting(person.id),
              onRename: (newName) {
                context.read<RenamePersonBloc>().add(
                  RenamePerson(id: person.id, newName: newName),
                );
              },
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
      },
    );
  }
}

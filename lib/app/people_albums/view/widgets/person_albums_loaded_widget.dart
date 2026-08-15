import 'package:flutter/material.dart';
import 'package:smart_gallery/app/people_albums/models/person_album_model.dart';
import 'package:smart_gallery/app/people_albums/view/widgets/person_albums_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';
import 'package:smart_gallery/core/widgets/search_widget.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class PersonAlbumsLoadedWidget extends StatelessWidget {
  const PersonAlbumsLoadedWidget({
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
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        SearchWidget(hintText: "Search for a person..."),

        SizedBox(height: AppDimensions.mp),

        SubtitleWidget(subtitle: "${personAlbums.length} People"),

        SizedBox(height: AppDimensions.mp),

        PersonAlbumsWidget(
          personAlbums: personAlbums,
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

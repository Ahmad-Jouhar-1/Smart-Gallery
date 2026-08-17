import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gallery/app/people_albums/controllers/fetch_people_bloc/fetch_people_bloc.dart';
import 'package:smart_gallery/app/people_albums/models/person_model.dart';
import 'package:smart_gallery/app/people_albums/views/widgets/people_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/extentions/dimensions_extensions/percent_sized_extension.dart';
import 'package:smart_gallery/core/widgets/search_widget.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class PeopleView extends StatelessWidget {
  const PeopleView({
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
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        SearchWidget(
          hintText: "Search for a person...",
          onChanged: (searchWord) {
            context.read<FetchPeopleBloc>().add(
              SearchPeople(searchWord: searchWord),
            );
          },
        ),
        SizedBox(height: AppDimensions.mp),
        SubtitleWidget(subtitle: "${people.length} People"),
        SizedBox(height: AppDimensions.mp),
        if (people.isEmpty)
          Padding(
            padding: EdgeInsets.all(AppDimensions.xlp),
            child: Text(
              "No people match your search.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.accentTextColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          PeopleWidget(
            people: people,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/people_albums/controllers/fetch_person_photos/fetch_person_photos_bloc.dart';
import 'package:smart_gallery/app/people_albums/models/person_album_model.dart';
import 'package:smart_gallery/app/people_albums/view/widgets/person_photos_failed_widget.dart';
import 'package:smart_gallery/app/people_albums/view/widgets/person_photos_loaded_empty_widget.dart';
import 'package:smart_gallery/app/people_albums/view/widgets/person_photos_loaded_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/controllers/selection/selection_bloc.dart';
import 'package:smart_gallery/core/services/media_share_service.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';
import 'package:smart_gallery/core/widgets/share_bar_widget.dart';
import 'package:smart_gallery/core/widgets/share_options_sheet_widget.dart';

class PersonAlbumScreen extends StatelessWidget {
  const PersonAlbumScreen({super.key, required this.person});

  final PersonAlbumModel person;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FetchPersonPhotosBloc>().add(
      FetchPersonPhotos(personId: person.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchPersonPhotosBloc()
            ..add(FetchPersonPhotos(personId: person.id)),
        ),
        BlocProvider(create: (context) => SelectionBloc()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBarWidget(
          title: person.name,
          subtitle: "${person.count} Photo",
          icon: Icons.arrow_forward_ios_rounded,
          onTap: Get.back,
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: AppColors.primaryColor,
              backgroundColor: AppColors.accentBackgroundColor,
              child: BlocBuilder<FetchPersonPhotosBloc, FetchPersonPhotosState>(
                builder: (context, state) {
                  switch (state) {
                    case FetchPersonPhotosLoading():
                      return LoadingWidget();
                    case FetchPersonPhotosLoaded():
                      return BlocBuilder<SelectionBloc, SelectionState>(
                        builder: (context, selectionState) {
                          return PersonPhotosLoadedWidget(
                            personPhotos: state.personPhotos,
                            selectedFilter: state.filter,
                            onFilterSelected: (filter) => context
                                .read<FetchPersonPhotosBloc>()
                                .add(FilterPersonPhotos(filter: filter)),
                            isSelecting: selectionState.isSelecting,
                            selectedIds: selectionState.selectedIds,
                            onStartSelecting: (id) => context
                                .read<SelectionBloc>()
                                .add(StartSelecting(id: id)),
                            onToggleSelected: (id) => context
                                .read<SelectionBloc>()
                                .add(ToggleSelected(id: id)),
                          );
                        },
                      );
                    case FetchPersonPhotosLoadedEmpty():
                      return PersonPhotosLoadedEmptyWidget(
                        image: "assets/images/similar_empty.png",
                        title: state.hasAnyPhoto
                            ? "No Results"
                            : "No Photos Found",
                        subtitle: state.hasAnyPhoto
                            ? "There are no photos within this time range."
                            : "Capture new moments or upload your favourite images.",
                      );
                    case FetchPersonPhotosFailed():
                      return PersonPhotosFailedWidget(
                        image: "assets/images/similar_empty.png",
                        title: "Something Went Wrong",
                        subtitle:
                            "Oops! An unexpected error occurred. Please try again in a moment.",
                        onTryAgain: () {
                          _onRefresh(context);
                        },
                      );
                  }
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<SelectionBloc, SelectionState>(
          builder: (context, selectionState) {
            if (!selectionState.isSelecting) return const SizedBox.shrink();

            return ShareBarWidget(
              selectedCount: selectionState.selectedIds.length,
              onCancel: () => context.read<SelectionBloc>().add(ClearSelection()),
              onShare: () => _share(context, selectionState.selectedIds),
            );
          },
        ),
      ),
    );
  }

  void _share(BuildContext context, Set<int> selectedIds) {
    final state = context.read<FetchPersonPhotosBloc>().state;
    if (state is! FetchPersonPhotosLoaded) return;

    final selectedPhotos = state.personPhotos
        .where((photo) => selectedIds.contains(photo.id))
        .toList();

    ShareOptionsSheetWidget.show(
      context,
      onPicked: () => MediaShareService.shareImages(
        selectedPhotos.map((photo) => photo.image).toList(),
        text: "${person.name}'s photos",
      ),
    );
  }
}

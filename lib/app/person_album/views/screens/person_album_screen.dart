import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/people_albums/models/person_model.dart';
import 'package:smart_gallery/app/person_album/controllers/filter_photos_bloc/filter_photos_bloc.dart';
import 'package:smart_gallery/app/person_album/controllers/person_album_bloc/person_album_bloc.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/app/person_album/views/widgets/photos_failed_widget.dart';
import 'package:smart_gallery/app/person_album/views/widgets/photos_view.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/controllers/selection/selection_bloc.dart';
import 'package:smart_gallery/core/services/media_share_service.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';
import 'package:smart_gallery/core/widgets/share_bar_widget.dart';
import 'package:smart_gallery/core/widgets/share_options_sheet_widget.dart';

class PersonAlbumScreen extends StatelessWidget {
  const PersonAlbumScreen({super.key, required this.person});

  final PersonModel person;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<SelectionBloc>().add(ClearSelection());
    context.read<PersonAlbumBloc>().add(
      FetchPersonAlbum(personId: person.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PersonAlbumBloc()
            ..add(FetchPersonAlbum(personId: person.id)),
        ),
        BlocProvider(create: (context) => FilterPhotosBloc()),
        BlocProvider(create: (context) => SelectionBloc()),
      ],
      child: BlocListener<PersonAlbumBloc, PersonAlbumState>(
        listener: (context, state) {
          if (state is PersonAlbumLoaded) {
            context.read<FilterPhotosBloc>().add(
              SetPhotos(photos: state.album.photos),
            );
          }
        },
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
                child: BlocBuilder<PersonAlbumBloc, PersonAlbumState>(
                  builder: (context, state) {
                    switch (state) {
                      case PersonAlbumLoading():
                        return LoadingWidget();
                      case PersonAlbumLoaded():
                        return _LoadedAlbum(albumState: state);
                      case PersonAlbumFailed():
                        return PhotosFailedWidget(
                          image: "assets/images/similar_empty.png",
                          title: "Something Went Wrong",
                          subtitle: state.errorMessage,
                          onTryAgain: () => _onRefresh(context),
                        );
                    }
                  },
                ),
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<SelectionBloc, SelectionState>(
            builder: (context, state) {
              if (!state.isSelecting) {
                return const SizedBox.shrink();
              }

              return ShareBarWidget(
                selectedCount: state.selectedIds.length,
                onCancel: () {
                  context.read<SelectionBloc>().add(ClearSelection());
                },
                onShare: () => _share(context, state.selectedIds),
              );
            },
          ),
        ),
      ),
    );
  }

  void _share(BuildContext context, Set<int> selectedIds) {
    final state = context.read<FilterPhotosBloc>().state;
    final photos = state is FilterPhotosLoaded
        ? state.photos
        : <PersonPhotoModel>[];
    final selectedPhotos = photos
        .where((photo) => selectedIds.contains(photo.id))
        .toList();

    if (selectedPhotos.isEmpty) {
      return;
    }

    ShareOptionsSheetWidget.show(
      context,
      onPicked: () => MediaShareService.shareImages(
        selectedPhotos.map((photo) => photo.image).toList(),
        text: "${person.name}'s photos",
      ),
    );
  }
}

class _LoadedAlbum extends StatelessWidget {
  const _LoadedAlbum({required this.albumState});

  final PersonAlbumLoaded albumState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterPhotosBloc, FilterPhotosState>(
      builder: (context, filterState) {
        if (filterState is FilterPhotosInitial) {
          return LoadingWidget();
        }

        final photos = filterState is FilterPhotosLoaded
            ? filterState.photos
            : <PersonPhotoModel>[];
        final filter = filterState is FilterPhotosLoaded
            ? filterState.filter
            : (filterState as FilterPhotosEmpty).filter;
        final hasPhotos = filterState is FilterPhotosLoaded
            ? true
            : (filterState as FilterPhotosEmpty).hasPhotos;

        return BlocBuilder<SelectionBloc, SelectionState>(
          builder: (context, selectionState) {
            return PhotosView(
              bestPhoto: albumState.album.bestPhoto,
              photos: photos,
              filter: filter,
              hasPhotos: hasPhotos,
              isSelecting: selectionState.isSelecting,
              selectedIds: selectionState.selectedIds,
              onFilterSelected: (filter) {
                context.read<SelectionBloc>().add(ClearSelection());
                context.read<FilterPhotosBloc>().add(
                  FilterByDate(filter: filter),
                );
              },
              onStartSelecting: (id) {
                context.read<SelectionBloc>().add(StartSelecting(id: id));
              },
              onToggleSelected: (id) {
                context.read<SelectionBloc>().add(ToggleSelected(id: id));
              },
            );
          },
        );
      },
    );
  }
}

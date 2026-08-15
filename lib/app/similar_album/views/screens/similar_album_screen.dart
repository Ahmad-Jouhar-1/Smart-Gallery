import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/similar_album/controllers/bloc/fetch_similar_album_photos_bloc.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_delete_bar_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photos_failed_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photos_loaded_widget.dart';
import 'package:smart_gallery/app/similar_albums/models/similar_album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/controllers/selection/selection_bloc.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';

class SimilarAlbumScreen extends StatelessWidget {
  const SimilarAlbumScreen({super.key, required this.similarAlbum});

  final SimilarAlbumModel similarAlbum;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FetchSimilarAlbumPhotosBloc>().add(
      FetchSimilarAlbumPhotos(similarAlbumId: similarAlbum.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  FetchSimilarAlbumPhotosBloc()..add(
                    FetchSimilarAlbumPhotos(similarAlbumId: similarAlbum.id),
                  ),
        ),
        BlocProvider(create: (context) => SelectionBloc()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBarWidget(
          title: similarAlbum.name,
          subtitle: "${similarAlbum.count} Photo",
          icon: Icons.arrow_forward_ios_rounded,
          onTap: Get.back,
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: AppColors.primaryColor,
              backgroundColor: AppColors.accentBackgroundColor,
              child: BlocBuilder<
                FetchSimilarAlbumPhotosBloc,
                FetchSimilarAlbumPhotosState
              >(
                builder: (context, state) {
                  switch (state) {
                    case FetchSimilarAlbumPhotosLoading():
                      return LoadingWidget();
                    case FetchSimilarAlbumPhotosLoaded():
                      return BlocBuilder<SelectionBloc, SelectionState>(
                        builder: (context, selectionState) {
                          return SimilarAlbumPhotosLoadedWidget(
                            similarAlbumBestPhoto: state.similarAlbumBestPhoto,
                            similarAlbumPhotos: state.similarAlbumPhotos,
                            isSelecting: selectionState.isSelecting,
                            selectedIds: selectionState.selectedIds,
                            onStartSelecting: (id) => context
                                .read<SelectionBloc>()
                                .add(StartSelecting(id: id)),
                            onToggleSelected: (id) => context
                                .read<SelectionBloc>()
                                .add(ToggleSelected(id: id)),
                            onDeleteAll: () => context.read<SelectionBloc>().add(
                              SelectMany(
                                ids: state.similarAlbumPhotos
                                    .where(
                                      (photo) =>
                                          photo.id !=
                                          state.similarAlbumBestPhoto.id,
                                    )
                                    .map((photo) => photo.id)
                                    .toSet(),
                              ),
                            ),
                          );
                        },
                      );
                    case FetchSimilarAlbumPhotosFailed():
                      return SimilarAlbumPhotosFailedWidget(
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

            return SimilarAlbumDeleteBarWidget(
              selectedCount: selectionState.selectedIds.length,
              onCancel: () => context.read<SelectionBloc>().add(ClearSelection()),
              onDelete: () {
                context.read<FetchSimilarAlbumPhotosBloc>().add(
                  DeleteSimilarAlbumPhotos(ids: selectionState.selectedIds),
                );
                context.read<SelectionBloc>().add(ClearSelection());
              },
            );
          },
        ),
      ),
    );
  }
}

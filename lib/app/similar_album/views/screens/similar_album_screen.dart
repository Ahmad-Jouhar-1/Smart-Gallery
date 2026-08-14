import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/similar_album/controllers/bloc/fetch_similar_album_photos_bloc.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photos_failed_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photos_loaded_widget.dart';
import 'package:smart_gallery/app/similar_albums/models/similar_album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
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
                      return SimilarAlbumPhotosLoadedWidget(
                        similarAlbumBestPhoto: state.similarAlbumBestPhoto,
                        similarAlbumPhotos: state.similarAlbumPhotos,
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
      ),
    );
  }
}

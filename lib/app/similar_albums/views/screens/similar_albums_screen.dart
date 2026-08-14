import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gallery/app/similar_albums/controllers/fetch_similar_album/fetch_similar_albums_bloc.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/similar_albums_failed_widget.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/similar_albums_loaded_empty_widget.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/similar_albums_loaded_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';

class SimilarAlbumsScreen extends StatelessWidget {
  const SimilarAlbumsScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FetchSimilarAlbumsBloc>().add(FetchSimilarAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => FetchSimilarAlbumsBloc()..add(FetchSimilarAlbums()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBarWidget(
          title: "AI Gallery",
          subtitle: "Similar Photos",
          icon: Icons.filter_alt_outlined,
          onTap: () {},
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: AppColors.primaryColor,
              backgroundColor: AppColors.accentBackgroundColor,
              child: BlocBuilder<
                FetchSimilarAlbumsBloc,
                FetchSimilarAlbumsState
              >(
                builder: (context, state) {
                  switch (state) {
                    case FetchSimilarAlbumsLoading():
                      return LoadingWidget();
                    case FetchSimilarAlbumsLoaded():
                      return SimilarAlbumLoadedWidget(
                        similarAlbums: state.similarAlbum,
                      );
                    case FetchSimilarAlbumsLoadedEmpty():
                      return SimilarAlbumsLoadedEmptyWidget(
                        image: "assets/images/similar_empty.png",
                        title: "No Pictures",
                        subtitle:
                            "Capture new moments or upload your favourite images.",
                      );
                    case FetchSimilarAlbumsFailed():
                      return SimilarAlbumsFailedWidget(
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

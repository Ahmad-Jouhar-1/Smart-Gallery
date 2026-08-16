import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gallery/app/similar_albums/controllers/fetch_albums_bloc/fetch_albums_bloc.dart';
import 'package:smart_gallery/app/similar_albums/controllers/rename_album_bloc/rename_album_bloc.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/albums_empty_widget.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/albums_failed_widget.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/albums_view.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FetchAlbumsBloc>().add(FetchAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchAlbumsBloc()..add(FetchAlbums()),
        ),
        BlocProvider(create: (context) => RenameAlbumBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RenameAlbumBloc, RenameAlbumState>(
            listener: (context, state) {
              if (state is RenameAlbumLoaded) {
                context.read<FetchAlbumsBloc>().add(
                  AlbumNameIsUpdated(
                    id: state.album.id,
                    newName: state.album.name,
                  ),
                );
              } else if (state is RenameAlbumFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
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
                child: BlocBuilder<FetchAlbumsBloc, FetchAlbumsState>(
                  builder: (context, state) {
                    switch (state) {
                      case FetchAlbumsLoading():
                        return LoadingWidget();
                      case FetchAlbumsLoaded():
                        return AlbumsView(albums: state.albums);
                      case FetchAlbumsLoadedEmpty():
                        return AlbumsEmptyWidget(
                          image: "assets/images/similar_empty.png",
                          title: "No Pictures",
                          subtitle:
                              "Capture new moments or upload your favourite images.",
                        );
                      case FetchAlbumsFailed():
                        return AlbumsFailedWidget(
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
        ),
      ),
    );
  }
}

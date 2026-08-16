import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gallery/app/similar_albums/controllers/fetch_albums_bloc/fetch_albums_bloc.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/albums_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/search_widget.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class AlbumsView extends StatelessWidget {
  const AlbumsView({super.key, required this.albums});

  final List<AlbumModel> albums;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        SearchWidget(
          hintText: "Search for album...",
          onChanged: (searchWord) {
            context.read<FetchAlbumsBloc>().add(
              SearchAlbums(searchWord: searchWord),
            );
          },
        ),
        SizedBox(height: AppDimensions.mp),
        SubtitleWidget(subtitle: "${albums.length} Similar Clusters"),
        SizedBox(height: AppDimensions.mp),
        if (albums.isEmpty)
          Padding(
            padding: EdgeInsets.all(AppDimensions.xlp),
            child: Text(
              "No albums match your search.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.accentTextColor,
                fontSize: AppDimensions.mfs,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        else
          AlbumsWidget(albums: albums),
      ],
    );
  }
}

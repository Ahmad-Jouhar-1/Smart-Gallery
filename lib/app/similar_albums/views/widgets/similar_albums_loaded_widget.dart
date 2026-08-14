import 'package:flutter/material.dart';
import 'package:smart_gallery/app/similar_albums/models/similar_album_model.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/similar_albums_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/search_widget.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class SimilarAlbumLoadedWidget extends StatelessWidget {
  const SimilarAlbumLoadedWidget({super.key, required this.similarAlbums});

  final List<SimilarAlbumModel> similarAlbums;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
      children: [
        SearchWidget(hintText: "Search for album..."),
        SizedBox(height: AppDimensions.mp),
        SubtitleWidget(subtitle: "${similarAlbums.length} Similar Clusters"),
        SizedBox(height: AppDimensions.mp),
        SimilarAlbumsWidget(similarAlbums: similarAlbums),
      ],
    );
  }
}

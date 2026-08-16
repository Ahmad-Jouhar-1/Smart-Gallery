import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/upload_consent/models/json_model.dart';
import 'package:smart_gallery/app/upload_consent/models/studio_album_model.dart';
import 'package:smart_gallery/app/upload_consent/view/widgets/studio_albums_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/subtitle_widget.dart';

class StudioAlbumPickerScreen extends StatelessWidget {
  const StudioAlbumPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StudioAlbumModel> albums = (studioAlbums as List<dynamic>)
        .map((album) => StudioAlbumModel.fromJson(album))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBarWidget(
        title: "Studio",
        subtitle: "Select an Album",
        icon: Icons.arrow_forward_ios_rounded,
        onTap: Get.back,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: AppDimensions.mp),
        children: [
          SubtitleWidget(subtitle: "${albums.length} Albums Found"),

          SizedBox(height: AppDimensions.mp),

          StudioAlbumsWidget(studioAlbums: albums),
        ],
      ),
    );
  }
}

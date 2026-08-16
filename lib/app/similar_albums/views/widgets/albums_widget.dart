import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/route_manager.dart';
import 'package:smart_gallery/app/similar_album/views/screens/cluster_screen.dart';
import 'package:smart_gallery/app/similar_albums/controllers/rename_album_bloc/rename_album_bloc.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/app/similar_albums/views/widgets/album_widget.dart';
import 'package:smart_gallery/core/constants/app_dimensions.dart';

class AlbumsWidget extends StatelessWidget {
  const AlbumsWidget({super.key, required this.albums});

  final List<AlbumModel> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.mp),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: albums.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimensions.sp,
        mainAxisSpacing: AppDimensions.mp,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final album = albums[index];

        return BlocBuilder<RenameAlbumBloc, RenameAlbumState>(
          buildWhen: (previous, current) {
            final previousId = previous is RenameAlbumLoading
                ? previous.albumId
                : null;
            final currentId = current is RenameAlbumLoading
                ? current.albumId
                : null;
            return previousId == album.id || currentId == album.id;
          },
          builder: (context, state) {
            return AlbumWidget(
              album: album,
              isRenaming:
                  state is RenameAlbumLoading && state.albumId == album.id,
              onTap: () {
                Get.to(
                  () => ClusterScreen(album: album),
                  transition: Transition.circularReveal,
                );
              },
              onRename: (newName) {
                context.read<RenameAlbumBloc>().add(
                  RenameAlbum(id: album.id, newName: newName),
                );
              },
            );
          },
        );
      },
    );
  }
}

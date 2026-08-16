import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/similar_album/controllers/cluster_bloc/cluster_bloc.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/delete_bar_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/photos_failed_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/photos_view.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/controllers/selection/selection_bloc.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';

class ClusterScreen extends StatelessWidget {
  const ClusterScreen({super.key, required this.album});

  final AlbumModel album;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ClusterBloc>().add(FetchCluster(clusterId: album.id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ClusterBloc()..add(FetchCluster(clusterId: album.id)),
        ),
        BlocProvider(create: (context) => SelectionBloc()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBarWidget(
          title: album.name,
          subtitle: "${album.count} Photo",
          icon: Icons.arrow_forward_ios_rounded,
          onTap: Get.back,
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              color: AppColors.primaryColor,
              backgroundColor: AppColors.accentBackgroundColor,
              child: BlocBuilder<ClusterBloc, ClusterState>(
                builder: (context, state) {
                  switch (state) {
                    case ClusterLoading():
                      return LoadingWidget();
                    case ClusterLoaded():
                      return BlocBuilder<SelectionBloc, SelectionState>(
                        builder: (context, selectionState) {
                          return PhotosView(
                            cluster: state.cluster,
                            isSelecting: selectionState.isSelecting,
                            selectedIds: selectionState.selectedIds,
                            onStartSelecting: (id) {
                              context.read<SelectionBloc>().add(
                                StartSelecting(id: id),
                              );
                            },
                            onToggleSelected: (id) {
                              context.read<SelectionBloc>().add(
                                ToggleSelected(id: id),
                              );
                            },
                            onDeleteAll: () {
                              context.read<SelectionBloc>().add(
                                SelectMany(
                                  ids: state.cluster.photos
                                      .where(
                                        (photo) =>
                                            photo.id !=
                                            state.cluster.bestPhoto.id,
                                      )
                                      .map((photo) => photo.id)
                                      .toSet(),
                                ),
                              );
                            },
                          );
                        },
                      );
                    case ClusterFailed():
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
          builder: (context, selectionState) {
            if (!selectionState.isSelecting) {
              return const SizedBox.shrink();
            }

            return DeleteBarWidget(
              selectedCount: selectionState.selectedIds.length,
              onCancel: () {
                context.read<SelectionBloc>().add(ClearSelection());
              },
              onDelete: () {
                context.read<ClusterBloc>().add(
                  DeletePhotos(ids: selectionState.selectedIds),
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

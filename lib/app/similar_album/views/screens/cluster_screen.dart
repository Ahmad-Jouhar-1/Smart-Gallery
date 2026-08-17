import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/similar_album/controllers/cluster_bloc/cluster_bloc.dart';
import 'package:smart_gallery/app/similar_album/controllers/delete_photos_bloc/delete_photos_bloc.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/delete_bar_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/photos_failed_widget.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/photos_view.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
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
        BlocProvider(create: (context) => DeletePhotosBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ClusterBloc, ClusterState>(
            listener: (context, state) {
              if (state is ClusterLoaded) {
                context.read<DeletePhotosBloc>().add(
                  SetDeletePhotos(
                    photos: state.cluster.photos,
                    bestPhotoId: state.cluster.bestPhoto.id,
                  ),
                );
              }
            },
          ),
          BlocListener<DeletePhotosBloc, DeletePhotosState>(
            listener: (context, state) {
              if (state is DeletePhotosLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${state.result.deletedCount} photos deleted.",
                    ),
                  ),
                );
                _onRefresh(context);
              } else if (state is DeletePhotosFailed) {
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
                        return BlocBuilder<DeletePhotosBloc, DeletePhotosState>(
                          builder: (context, deleteState) {
                            return PhotosView(
                              cluster: state.cluster,
                              isSelecting: deleteState.isSelecting,
                              selectedIds: deleteState.selectedIds,
                              onStartSelecting: (id) {
                                context.read<DeletePhotosBloc>().add(
                                  StartSelecting(id: id),
                                );
                              },
                              onToggleSelected: (id) {
                                context.read<DeletePhotosBloc>().add(
                                  TogglePhoto(id: id),
                                );
                              },
                              onSelectSuggested: () {
                                context.read<DeletePhotosBloc>().add(
                                  SelectSuggested(),
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
          bottomNavigationBar:
              BlocBuilder<DeletePhotosBloc, DeletePhotosState>(
                builder: (context, state) {
                  if (!state.isSelecting) {
                    return const SizedBox.shrink();
                  }

                  return DeleteBarWidget(
                    selectedCount: state.selectedIds.length,
                    isLoading: state.isLoading,
                    onCancel: () {
                      context.read<DeletePhotosBloc>().add(
                        CancelSelecting(),
                      );
                    },
                    onDelete: () {
                      context.read<DeletePhotosBloc>().add(DeleteSelected());
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}

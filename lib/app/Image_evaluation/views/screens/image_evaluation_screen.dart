import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:smart_gallery/app/Image_evaluation/controllers/bloc/fetch_image_evaluation_bloc.dart';
import 'package:smart_gallery/app/Image_evaluation/views/widgets/image_evaluation_loaded_widget.dart';
import 'package:smart_gallery/app/similar_album/models/similar_album_photo_model.dart';
import 'package:smart_gallery/app/similar_album/views/widgets/similar_album_photos_failed_widget.dart';
import 'package:smart_gallery/core/constants/app_colors.dart';
import 'package:smart_gallery/core/widgets/app_bar_widget.dart';
import 'package:smart_gallery/core/widgets/loading_widget.dart';

class ImageEvaluationScreen extends StatelessWidget {
  const ImageEvaluationScreen({super.key, required this.similarAlbumPhoto});

  final SimilarAlbumPhotoModel similarAlbumPhoto;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FetchImageEvaluationBloc>().add(
      FetchImageEvaluation(photoId: similarAlbumPhoto.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  FetchImageEvaluationBloc()
                    ..add(FetchImageEvaluation(photoId: similarAlbumPhoto.id)),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBarWidget(
          title: "Image Evaluation",
          subtitle: "Quality Analysis",
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
                FetchImageEvaluationBloc,
                FetchImageEvaluationState
              >(
                builder: (context, state) {
                  switch (state) {
                    case FetchImageEvaluationLoading():
                      return LoadingWidget();
                    case FetchImageEvaluationLoaded():
                      return ImageEvaluationLoadedWidget(
                        similarAlbumPhoto: similarAlbumPhoto,
                        imageEvaluation: state.imageEvaluation,
                      );

                    case FetchImageEvaluationFailed():
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

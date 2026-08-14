import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/similar_album/models/json_model.dart';
import 'package:smart_gallery/app/similar_album/models/similar_album_photo_model.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_similar_album_photos_event.dart';
part 'fetch_similar_album_photos_state.dart';

class FetchSimilarAlbumPhotosBloc
    extends Bloc<FetchSimilarAlbumPhotosEvent, FetchSimilarAlbumPhotosState> {
  FetchSimilarAlbumPhotosBloc() : super(FetchSimilarAlbumPhotosLoading()) {
    on<FetchSimilarAlbumPhotos>((event, emit) async {
      emit(FetchSimilarAlbumPhotosLoading());

      try {
        await Future.delayed(Duration(seconds: 5));

        SimilarAlbumPhotoModel mySimilarAlbumBestPhoto =
            SimilarAlbumPhotoModel.fromJson(
              similarAlbumsPhotos[event.similarAlbumId]?["best_photo"]
                  as Map<String, dynamic>,
            );

        List<SimilarAlbumPhotoModel> mySimilarAlbumPhotos =
            (similarAlbumsPhotos[event.similarAlbumId]?["all_photos"]
                    as List<dynamic>)
                .map(
                  (similarAlbumPhoto) =>
                      SimilarAlbumPhotoModel.fromJson(similarAlbumPhoto),
                )
                .toList();

        emit(
          FetchSimilarAlbumPhotosLoaded(
            similarAlbumBestPhoto: mySimilarAlbumBestPhoto,
            similarAlbumPhotos: mySimilarAlbumPhotos,
          ),
        );
      } on ServerException catch (e) {
        emit(
          FetchSimilarAlbumPhotosFailed(
            errorMessage: e.errorModel.errorMessage,
          ),
        );
      }
    });
  }
}

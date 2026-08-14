part of 'fetch_similar_album_photos_bloc.dart';

@immutable
sealed class FetchSimilarAlbumPhotosState {}

final class FetchSimilarAlbumPhotosLoading
    extends FetchSimilarAlbumPhotosState {}

final class FetchSimilarAlbumPhotosLoaded extends FetchSimilarAlbumPhotosState {
  final SimilarAlbumPhotoModel similarAlbumBestPhoto;
  final List<SimilarAlbumPhotoModel> similarAlbumPhotos;
  FetchSimilarAlbumPhotosLoaded({
    required this.similarAlbumBestPhoto,
    required this.similarAlbumPhotos,
  });
}

class FetchSimilarAlbumPhotosFailed extends FetchSimilarAlbumPhotosState {
  final String errorMessage;

  FetchSimilarAlbumPhotosFailed({required this.errorMessage});
}

part of 'fetch_similar_album_photos_bloc.dart';

@immutable
sealed class FetchSimilarAlbumPhotosEvent {}

class FetchSimilarAlbumPhotos extends FetchSimilarAlbumPhotosEvent {
  final int similarAlbumId;

  FetchSimilarAlbumPhotos({required this.similarAlbumId});
}

class DeleteSimilarAlbumPhotos extends FetchSimilarAlbumPhotosEvent {
  final Set<int> ids;

  DeleteSimilarAlbumPhotos({required this.ids});
}

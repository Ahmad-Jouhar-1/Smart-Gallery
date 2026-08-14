part of 'fetch_similar_albums_bloc.dart';

@immutable
sealed class FetchSimilarAlbumsState {}

final class FetchSimilarAlbumsLoading extends FetchSimilarAlbumsState {}

final class FetchSimilarAlbumsLoaded extends FetchSimilarAlbumsState {
  final List<SimilarAlbumModel> similarAlbum;
  FetchSimilarAlbumsLoaded({required this.similarAlbum});
}

class FetchSimilarAlbumsLoadedEmpty extends FetchSimilarAlbumsState {}

class FetchSimilarAlbumsFailed extends FetchSimilarAlbumsState {
  final String errorMessage;

  FetchSimilarAlbumsFailed({required this.errorMessage});
}

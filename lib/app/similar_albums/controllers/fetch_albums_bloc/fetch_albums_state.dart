part of 'fetch_albums_bloc.dart';

@immutable
sealed class FetchAlbumsState {}

final class FetchAlbumsLoading extends FetchAlbumsState {}

final class FetchAlbumsLoaded extends FetchAlbumsState {
  final List<AlbumModel> albums;

  FetchAlbumsLoaded({required this.albums});
}

final class FetchAlbumsLoadedEmpty extends FetchAlbumsState {}

final class FetchAlbumsFailed extends FetchAlbumsState {
  final String errorMessage;

  FetchAlbumsFailed({required this.errorMessage});
}

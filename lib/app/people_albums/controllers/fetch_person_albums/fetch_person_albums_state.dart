part of 'fetch_person_albums_bloc.dart';

@immutable
sealed class FetchPersonAlbumsState {}

final class FetchPersonAlbumsLoading extends FetchPersonAlbumsState {}

final class FetchPersonAlbumsLoaded extends FetchPersonAlbumsState {
  final List<PersonAlbumModel> personAlbums;
  FetchPersonAlbumsLoaded({required this.personAlbums});
}

class FetchPersonAlbumsLoadedEmpty extends FetchPersonAlbumsState {}

class FetchPersonAlbumsFailed extends FetchPersonAlbumsState {
  final String errorMessage;

  FetchPersonAlbumsFailed({required this.errorMessage});
}

part of 'person_album_bloc.dart';

@immutable
sealed class PersonAlbumState {}

final class PersonAlbumLoading extends PersonAlbumState {}

final class PersonAlbumLoaded extends PersonAlbumState {
  final PersonAlbumModel album;

  PersonAlbumLoaded({required this.album});
}

final class PersonAlbumFailed extends PersonAlbumState {
  final String errorMessage;

  PersonAlbumFailed({required this.errorMessage});
}

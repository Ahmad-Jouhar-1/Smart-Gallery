part of 'rename_album_bloc.dart';

@immutable
sealed class RenameAlbumState {}

final class RenameAlbumInitial extends RenameAlbumState {}

final class RenameAlbumLoading extends RenameAlbumState {
  final int albumId;

  RenameAlbumLoading({required this.albumId});
}

final class RenameAlbumLoaded extends RenameAlbumState {
  final AlbumModel album;

  RenameAlbumLoaded({required this.album});
}

final class RenameAlbumFailed extends RenameAlbumState {
  final String errorMessage;

  RenameAlbumFailed({required this.errorMessage});
}

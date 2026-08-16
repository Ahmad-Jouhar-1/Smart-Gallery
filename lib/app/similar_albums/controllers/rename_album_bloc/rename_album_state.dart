part of 'rename_album_bloc.dart';

@immutable
sealed class RenameAlbumState {}

final class RenameAlbumInitial extends RenameAlbumState {}

final class RenameAlbumLoading extends RenameAlbumState {
  final int albumId;

  RenameAlbumLoading({required this.albumId});
}

final class RenameAlbumLoaded extends RenameAlbumState {
  final int id;
  final String newName;

  RenameAlbumLoaded({required this.id, required this.newName});
}

final class RenameAlbumFailed extends RenameAlbumState {
  final String errorMessage;

  RenameAlbumFailed({required this.errorMessage});
}

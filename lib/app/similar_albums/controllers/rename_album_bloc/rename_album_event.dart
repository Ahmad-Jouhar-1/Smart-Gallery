part of 'rename_album_bloc.dart';

@immutable
sealed class RenameAlbumEvent {}

final class RenameAlbum extends RenameAlbumEvent {
  final int id;
  final String newName;

  RenameAlbum({required this.id, required this.newName});
}

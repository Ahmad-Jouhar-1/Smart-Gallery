part of 'fetch_person_albums_bloc.dart';

@immutable
sealed class FetchPersonAlbumsEvent {}

class FetchPersonAlbums extends FetchPersonAlbumsEvent {}

class RenamePersonAlbum extends FetchPersonAlbumsEvent {
  final int id;
  final String newName;

  RenamePersonAlbum({required this.id, required this.newName});
}

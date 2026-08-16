part of 'fetch_albums_bloc.dart';

@immutable
sealed class FetchAlbumsEvent {}

final class FetchAlbums extends FetchAlbumsEvent {}

final class SearchAlbums extends FetchAlbumsEvent {
  final String searchWord;

  SearchAlbums({required this.searchWord});
}

final class AlbumNameIsUpdated extends FetchAlbumsEvent {
  final int id;
  final String newName;

  AlbumNameIsUpdated({required this.id, required this.newName});
}

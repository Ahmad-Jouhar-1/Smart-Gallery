part of 'fetch_similar_albums_bloc.dart';

@immutable
sealed class FetchSimilarAlbumsEvent {}

class FetchSimilarAlbums extends FetchSimilarAlbumsEvent {}

class RenameSimilarAlbum extends FetchSimilarAlbumsEvent {
  final int id;
  final String newName;

  RenameSimilarAlbum({required this.id, required this.newName});
}

part of 'analyze_album_bloc.dart';

@immutable
sealed class AnalyzeAlbumEvent {}

class StartAnalyzingAlbum extends AnalyzeAlbumEvent {
  final int albumId;

  StartAnalyzingAlbum({required this.albumId});
}

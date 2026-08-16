part of 'analyze_album_bloc.dart';

@immutable
sealed class AnalyzeAlbumEvent {}

class StartAnalyzingAlbum extends AnalyzeAlbumEvent {
  final AssetPathEntity album;

  StartAnalyzingAlbum({required this.album});
}

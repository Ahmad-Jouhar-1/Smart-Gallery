part of 'analyze_album_bloc.dart';

@immutable
sealed class AnalyzeAlbumState {}

final class AnalyzeAlbumInProgress extends AnalyzeAlbumState {
  final int progress;

  AnalyzeAlbumInProgress({required this.progress});
}

final class AnalyzeAlbumCompleted extends AnalyzeAlbumState {}

final class AnalyzeAlbumFailed extends AnalyzeAlbumState {
  final String errorMessage;

  AnalyzeAlbumFailed({required this.errorMessage});
}

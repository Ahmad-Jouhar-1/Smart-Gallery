import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'analyze_album_event.dart';
part 'analyze_album_state.dart';

class AnalyzeAlbumBloc extends Bloc<AnalyzeAlbumEvent, AnalyzeAlbumState> {
  AnalyzeAlbumBloc() : super(AnalyzeAlbumInProgress(progress: 0)) {
    on<StartAnalyzingAlbum>((event, emit) async {
      for (int progress = 0; progress <= 100; progress += 5) {
        await Future.delayed(Duration(milliseconds: 90));
        emit(AnalyzeAlbumInProgress(progress: progress));
      }

      emit(AnalyzeAlbumCompleted());
    });
  }
}

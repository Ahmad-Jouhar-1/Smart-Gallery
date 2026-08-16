import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/similar_albums/models/json_model.dart';
import 'package:smart_gallery/app/similar_albums/models/similar_album_model.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_similar_albums_event.dart';
part 'fetch_similar_albums_state.dart';

class FetchSimilarAlbumsBloc
    extends Bloc<FetchSimilarAlbumsEvent, FetchSimilarAlbumsState> {
  FetchSimilarAlbumsBloc() : super(FetchSimilarAlbumsLoading()) {
    on<FetchSimilarAlbums>((event, emit) async {
      emit(FetchSimilarAlbumsLoading());

      try {
        await Future.delayed(Duration(seconds: 5));

        _allSimilarAlbums = (similarAlbums as List<dynamic>)
            .map((similarAlbum) => SimilarAlbumModel.fromJson(similarAlbum))
            .toList();

        _emitLoaded(emit);
      } on ServerException catch (e) {
        emit(FetchSimilarAlbumsFailed(errorMessage: e.errorModel.errorMessage));
      }
    });

    on<RenameSimilarAlbum>((event, emit) {
      _allSimilarAlbums = _allSimilarAlbums
          .map(
            (album) => album.id == event.id
                ? album.copyWith(name: event.newName)
                : album,
          )
          .toList();

      _emitLoaded(emit);
    });
  }

  List<SimilarAlbumModel> _allSimilarAlbums = [];

  void _emitLoaded(Emitter<FetchSimilarAlbumsState> emit) {
    if (_allSimilarAlbums.isEmpty) {
      emit(FetchSimilarAlbumsLoadedEmpty());
    } else {
      emit(FetchSimilarAlbumsLoaded(similarAlbum: _allSimilarAlbums));
    }
  }
}

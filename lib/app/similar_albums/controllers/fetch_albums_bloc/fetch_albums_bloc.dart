import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_albums_event.dart';
part 'fetch_albums_state.dart';

class FetchAlbumsBloc extends Bloc<FetchAlbumsEvent, FetchAlbumsState> {
  FetchAlbumsBloc() : super(FetchAlbumsLoading()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<FetchAlbums>((event, emit) async {
      emit(FetchAlbumsLoading());

      try {
        final response = await api.get(EndPoints.similarityClusters);

        _albums = (response as List<dynamic>)
            .map((album) => AlbumModel.fromJson(album))
            .toList();
        _filterAlbums();

        _emitLoaded(emit);
      } on ServerException catch (e) {
        emit(FetchAlbumsFailed(errorMessage: e.errorModel.errorMessage));
      }
    });

    on<SearchAlbums>((event, emit) {
      _searchWord = event.searchWord.trim().toLowerCase();
      _filterAlbums();

      _emitLoaded(emit);
    });

    on<AlbumNameIsUpdated>((event, emit) {
      _albums = _albums
          .map(
            (album) => album.id == event.id
                ? album.copyWith(name: event.newName)
                : album,
          )
          .toList();

      _filterAlbums();

      _emitLoaded(emit);
    });
  }

  List<AlbumModel> _albums = [];
  List<AlbumModel> _visibleAlbums = [];
  String _searchWord = '';

  void _filterAlbums() {
    _visibleAlbums = _searchWord.isEmpty
        ? List<AlbumModel>.from(_albums)
        : _albums
              .where((album) => album.name.toLowerCase().contains(_searchWord))
              .toList();
  }

  void _emitLoaded(Emitter<FetchAlbumsState> emit) {
    if (_albums.isEmpty) {
      emit(FetchAlbumsLoadedEmpty());
    } else {
      emit(FetchAlbumsLoaded(albums: _visibleAlbums));
    }
  }
}

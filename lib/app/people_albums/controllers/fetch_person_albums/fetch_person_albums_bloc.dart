import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/people_albums/models/json_model.dart';
import 'package:smart_gallery/app/people_albums/models/person_album_model.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_person_albums_event.dart';
part 'fetch_person_albums_state.dart';

class FetchPersonAlbumsBloc
    extends Bloc<FetchPersonAlbumsEvent, FetchPersonAlbumsState> {
  FetchPersonAlbumsBloc() : super(FetchPersonAlbumsLoading()) {
    on<FetchPersonAlbums>((event, emit) async {
      emit(FetchPersonAlbumsLoading());

      try {
        await Future.delayed(Duration(seconds: 1));

        List<PersonAlbumModel> myPersonAlbums = (personAlbums as List<dynamic>)
            .map((personAlbum) => PersonAlbumModel.fromJson(personAlbum))
            .toList();

        if (myPersonAlbums.isEmpty) {
          emit(FetchPersonAlbumsLoadedEmpty());
        } else {
          emit(FetchPersonAlbumsLoaded(personAlbums: myPersonAlbums));
        }
      } on ServerException catch (e) {
        emit(FetchPersonAlbumsFailed(errorMessage: e.errorModel.errorMessage));
      }
    });
  }
}

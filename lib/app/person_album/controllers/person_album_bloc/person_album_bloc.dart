import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/person_album/models/person_album_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'person_album_event.dart';
part 'person_album_state.dart';

class PersonAlbumBloc extends Bloc<PersonAlbumEvent, PersonAlbumState> {
  PersonAlbumBloc() : super(PersonAlbumLoading()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<FetchPersonAlbum>((event, emit) async {
      emit(PersonAlbumLoading());

      try {
        final response = await api.get(EndPoints.person(event.personId));
        final album = PersonAlbumModel.fromJson(
          response as Map<String, dynamic>,
        );

        emit(PersonAlbumLoaded(album: album));
      } on ServerException catch (e) {
        emit(PersonAlbumFailed(errorMessage: e.errorModel.errorMessage));
      } catch (_) {
        emit(
          PersonAlbumFailed(
            errorMessage: 'The server returned an invalid response.',
          ),
        );
      }
    });
  }
}

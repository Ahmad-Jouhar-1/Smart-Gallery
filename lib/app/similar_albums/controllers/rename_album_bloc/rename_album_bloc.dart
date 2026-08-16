import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/similar_albums/models/album_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'rename_album_event.dart';
part 'rename_album_state.dart';

class RenameAlbumBloc extends Bloc<RenameAlbumEvent, RenameAlbumState> {
  RenameAlbumBloc() : super(RenameAlbumInitial()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<RenameAlbum>((event, emit) async {
      final newName = event.newName.trim();

      if (newName.isEmpty) {
        emit(RenameAlbumFailed(errorMessage: "Album name can't be empty."));
        return;
      }

      emit(RenameAlbumLoading(albumId: event.id));

      try {
        final response = await api.patch(
          EndPoints.cluster(event.id),
          data: {
            ApiKey.newName: newName,
          },
        );
        final album = AlbumModel.fromJson(
          response as Map<String, dynamic>,
        );

        emit(RenameAlbumLoaded(album: album));
      } on ServerException catch (e) {
        emit(RenameAlbumFailed(errorMessage: e.errorModel.errorMessage));
      }
    });
  }
}

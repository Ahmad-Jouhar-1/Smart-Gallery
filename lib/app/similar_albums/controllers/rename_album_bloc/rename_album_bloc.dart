import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'rename_album_event.dart';
part 'rename_album_state.dart';

class RenameAlbumBloc extends Bloc<RenameAlbumEvent, RenameAlbumState> {
  RenameAlbumBloc() : super(RenameAlbumInitial()) {
    on<RenameAlbum>((event, emit) async {
      final newName = event.newName.trim();

      if (newName.isEmpty) {
        emit(RenameAlbumFailed(errorMessage: "Album name can't be empty."));
        return;
      }

      emit(RenameAlbumLoading(albumId: event.id));

      try {
        // Mock request. Replace this delay with the rename API request later.
        await Future.delayed(const Duration(milliseconds: 500));

        emit(RenameAlbumLoaded(id: event.id, newName: newName));
      } on ServerException catch (e) {
        emit(RenameAlbumFailed(errorMessage: e.errorModel.errorMessage));
      }
    });
  }
}

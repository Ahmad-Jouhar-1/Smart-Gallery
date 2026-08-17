import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/similar_album/models/delete_result_model.dart';
import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'delete_photos_event.dart';
part 'delete_photos_state.dart';

class DeletePhotosBloc extends Bloc<DeletePhotosEvent, DeletePhotosState> {
  DeletePhotosBloc() : super(DeletePhotosInitial()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<SetDeletePhotos>((event, emit) {
      if (state is DeletePhotosLoading) {
        return;
      }

      _selectedIds = {};
      _suggestedIds = event.photos
          .where(
            (photo) =>
                photo.isSelected && photo.id != event.bestPhotoId,
          )
          .map((photo) => photo.id)
          .toSet();

      emit(DeletePhotosReady(suggestedIds: _suggestedIds));
    });

    on<StartSelecting>((event, emit) {
      if (state is DeletePhotosLoading) {
        return;
      }

      _selectedIds = Set<int>.from(_selectedIds)..add(event.id);
      _emitSelecting(emit);
    });

    on<TogglePhoto>((event, emit) {
      if (state is DeletePhotosLoading) {
        return;
      }

      _selectedIds = Set<int>.from(_selectedIds);
      if (_selectedIds.contains(event.id)) {
        _selectedIds.remove(event.id);
      } else {
        _selectedIds.add(event.id);
      }

      _emitSelecting(emit);
    });

    on<SelectSuggested>((event, emit) {
      if (state is DeletePhotosLoading || _suggestedIds.isEmpty) {
        return;
      }

      _selectedIds = Set<int>.from(_suggestedIds);
      _emitSelecting(emit);
    });

    on<CancelSelecting>((event, emit) {
      if (state is DeletePhotosLoading) {
        return;
      }

      _selectedIds = {};
      emit(DeletePhotosReady(suggestedIds: _suggestedIds));
    });

    on<DeleteSelected>((event, emit) async {
      if (_selectedIds.isEmpty || state is DeletePhotosLoading) {
        return;
      }

      final selectedIds = Set<int>.from(_selectedIds);
      emit(
        DeletePhotosLoading(
          selectedIds: selectedIds,
          suggestedIds: _suggestedIds,
        ),
      );

      try {
        final response = await api.delete(
          EndPoints.deleteImages,
          data: {
            ApiKey.images: selectedIds
                .map(
                  (id) => {
                    ApiKey.id: id,
                    ApiKey.isSelected: true,
                  },
                )
                .toList(),
          },
        );
        final result = DeleteResultModel.fromJson(
          response as Map<String, dynamic>,
        );

        _selectedIds = {};
        _suggestedIds = Set<int>.from(_suggestedIds)
          ..removeAll(result.deletedIds);

        emit(DeletePhotosLoaded(result: result));
      } on ServerException catch (e) {
        emit(
          DeletePhotosFailed(
            errorMessage: e.errorModel.errorMessage,
            selectedIds: selectedIds,
            suggestedIds: _suggestedIds,
          ),
        );
      } catch (_) {
        emit(
          DeletePhotosFailed(
            errorMessage: 'The server returned an invalid response.',
            selectedIds: selectedIds,
            suggestedIds: _suggestedIds,
          ),
        );
      }
    });
  }

  Set<int> _selectedIds = {};
  Set<int> _suggestedIds = {};

  void _emitSelecting(Emitter<DeletePhotosState> emit) {
    emit(
      DeletePhotosSelecting(
        selectedIds: _selectedIds,
        suggestedIds: _suggestedIds,
      ),
    );
  }
}

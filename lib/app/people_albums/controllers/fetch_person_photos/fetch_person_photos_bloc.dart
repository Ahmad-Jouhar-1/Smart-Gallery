import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/people_albums/models/person_photo_date_filter.dart';
import 'package:smart_gallery/app/people_albums/models/person_photo_model.dart';
import 'package:smart_gallery/app/people_albums/models/person_photos_json_model.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_person_photos_event.dart';
part 'fetch_person_photos_state.dart';

class FetchPersonPhotosBloc
    extends Bloc<FetchPersonPhotosEvent, FetchPersonPhotosState> {
  FetchPersonPhotosBloc() : super(FetchPersonPhotosLoading()) {
    on<FetchPersonPhotos>((event, emit) async {
      emit(FetchPersonPhotosLoading());

      try {
        await Future.delayed(Duration(seconds: 1));

        final now = DateTime.now();
        final rawPersonPhotos =
            (personPhotos[event.personId] ?? []) as List<dynamic>;

        _allPersonPhotos = rawPersonPhotos.asMap().entries.map((entry) {
          final offsetDays = _dateOffsetsInDays[entry.key % _dateOffsetsInDays.length];

          return PersonPhotoModel.fromJson(
            entry.value,
            dateTime: now.subtract(Duration(days: offsetDays)),
          );
        }).toList();

        _emitFiltered(emit);
      } on ServerException catch (e) {
        emit(FetchPersonPhotosFailed(errorMessage: e.errorModel.errorMessage));
      }
    });

    on<FilterPersonPhotos>((event, emit) {
      _currentFilter = event.filter;
      _emitFiltered(emit);
    });
  }

  List<PersonPhotoModel> _allPersonPhotos = [];
  PersonPhotoDateFilter _currentFilter = PersonPhotoDateFilter.all;

  static const List<int> _dateOffsetsInDays = [0, 3, 20, 220];

  void _emitFiltered(Emitter<FetchPersonPhotosState> emit) {
    final now = DateTime.now();
    final filtered = _allPersonPhotos
        .where((photo) => _currentFilter.matches(photo.dateTime, now))
        .toList();

    if (filtered.isEmpty) {
      emit(
        FetchPersonPhotosLoadedEmpty(
          filter: _currentFilter,
          hasAnyPhoto: _allPersonPhotos.isNotEmpty,
        ),
      );
    } else {
      emit(
        FetchPersonPhotosLoaded(personPhotos: filtered, filter: _currentFilter),
      );
    }
  }
}

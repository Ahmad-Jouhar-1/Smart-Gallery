import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/person_album/models/date_filter.dart';
import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';

part 'filter_photos_event.dart';
part 'filter_photos_state.dart';

class FilterPhotosBloc extends Bloc<FilterPhotosEvent, FilterPhotosState> {
  FilterPhotosBloc() : super(FilterPhotosInitial()) {
    on<SetPhotos>((event, emit) {
      _photos = event.photos;
      _filter = DateFilter.all;
      _emitPhotos(emit);
    });

    on<FilterByDate>((event, emit) {
      _filter = event.filter;
      _emitPhotos(emit);
    });
  }

  List<PersonPhotoModel> _photos = [];
  DateFilter _filter = DateFilter.all;

  void _emitPhotos(Emitter<FilterPhotosState> emit) {
    final now = DateTime.now();
    final photos = _photos
        .where((photo) => _filter.matches(photo.capturedAt, now))
        .toList();

    if (photos.isEmpty) {
      emit(
        FilterPhotosEmpty(
          filter: _filter,
          hasPhotos: _photos.isNotEmpty,
        ),
      );
      return;
    }

    emit(FilterPhotosLoaded(photos: photos, filter: _filter));
  }
}

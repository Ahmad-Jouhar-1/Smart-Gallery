part of 'filter_photos_bloc.dart';

@immutable
sealed class FilterPhotosEvent {}

final class SetPhotos extends FilterPhotosEvent {
  final List<PersonPhotoModel> photos;

  SetPhotos({required this.photos});
}

final class FilterByDate extends FilterPhotosEvent {
  final DateFilter filter;

  FilterByDate({required this.filter});
}

part of 'fetch_person_photos_bloc.dart';

@immutable
sealed class FetchPersonPhotosEvent {}

class FetchPersonPhotos extends FetchPersonPhotosEvent {
  final int personId;

  FetchPersonPhotos({required this.personId});
}

class FilterPersonPhotos extends FetchPersonPhotosEvent {
  final PersonPhotoDateFilter filter;

  FilterPersonPhotos({required this.filter});
}

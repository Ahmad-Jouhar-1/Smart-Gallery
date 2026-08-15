part of 'fetch_person_photos_bloc.dart';

@immutable
sealed class FetchPersonPhotosState {}

final class FetchPersonPhotosLoading extends FetchPersonPhotosState {}

final class FetchPersonPhotosLoaded extends FetchPersonPhotosState {
  final List<PersonPhotoModel> personPhotos;
  final PersonPhotoDateFilter filter;

  FetchPersonPhotosLoaded({required this.personPhotos, required this.filter});
}

class FetchPersonPhotosLoadedEmpty extends FetchPersonPhotosState {
  final PersonPhotoDateFilter filter;
  final bool hasAnyPhoto;

  FetchPersonPhotosLoadedEmpty({required this.filter, required this.hasAnyPhoto});
}

class FetchPersonPhotosFailed extends FetchPersonPhotosState {
  final String errorMessage;

  FetchPersonPhotosFailed({required this.errorMessage});
}

part of 'filter_photos_bloc.dart';

@immutable
sealed class FilterPhotosState {}

final class FilterPhotosInitial extends FilterPhotosState {}

final class FilterPhotosLoaded extends FilterPhotosState {
  final List<PersonPhotoModel> photos;
  final DateFilter filter;

  FilterPhotosLoaded({required this.photos, required this.filter});
}

final class FilterPhotosEmpty extends FilterPhotosState {
  final DateFilter filter;
  final bool hasPhotos;

  FilterPhotosEmpty({required this.filter, required this.hasPhotos});
}

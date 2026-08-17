part of 'delete_photos_bloc.dart';

@immutable
sealed class DeletePhotosEvent {}

final class SetDeletePhotos extends DeletePhotosEvent {
  final List<PhotoModel> photos;
  final int bestPhotoId;

  SetDeletePhotos({required this.photos, required this.bestPhotoId});
}

final class StartSelecting extends DeletePhotosEvent {
  final int id;

  StartSelecting({required this.id});
}

final class TogglePhoto extends DeletePhotosEvent {
  final int id;

  TogglePhoto({required this.id});
}

final class SelectSuggested extends DeletePhotosEvent {}

final class CancelSelecting extends DeletePhotosEvent {}

final class DeleteSelected extends DeletePhotosEvent {}

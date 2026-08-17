part of 'delete_photos_bloc.dart';

@immutable
sealed class DeletePhotosState {
  bool get isSelecting => false;
  bool get isLoading => false;
  Set<int> get selectedIds => const <int>{};
  Set<int> get suggestedIds => const <int>{};
}

final class DeletePhotosInitial extends DeletePhotosState {}

final class DeletePhotosReady extends DeletePhotosState {
  @override
  final Set<int> suggestedIds;

  DeletePhotosReady({required this.suggestedIds});
}

final class DeletePhotosSelecting extends DeletePhotosState {
  @override
  final Set<int> selectedIds;
  @override
  final Set<int> suggestedIds;

  @override
  bool get isSelecting => true;

  DeletePhotosSelecting({
    required this.selectedIds,
    required this.suggestedIds,
  });
}

final class DeletePhotosLoading extends DeletePhotosState {
  @override
  final Set<int> selectedIds;
  @override
  final Set<int> suggestedIds;

  @override
  bool get isSelecting => true;

  @override
  bool get isLoading => true;

  DeletePhotosLoading({
    required this.selectedIds,
    required this.suggestedIds,
  });
}

final class DeletePhotosLoaded extends DeletePhotosState {
  final DeleteResultModel result;

  DeletePhotosLoaded({required this.result});
}

final class DeletePhotosFailed extends DeletePhotosState {
  final String errorMessage;
  @override
  final Set<int> selectedIds;
  @override
  final Set<int> suggestedIds;

  @override
  bool get isSelecting => true;

  DeletePhotosFailed({
    required this.errorMessage,
    required this.selectedIds,
    required this.suggestedIds,
  });
}

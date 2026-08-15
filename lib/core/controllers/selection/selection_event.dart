part of 'selection_bloc.dart';

@immutable
sealed class SelectionEvent {}

class StartSelecting extends SelectionEvent {
  final int id;

  StartSelecting({required this.id});
}

class ToggleSelected extends SelectionEvent {
  final int id;

  ToggleSelected({required this.id});
}

class SelectMany extends SelectionEvent {
  final Set<int> ids;

  SelectMany({required this.ids});
}

class ClearSelection extends SelectionEvent {}

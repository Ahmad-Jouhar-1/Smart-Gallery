part of 'selection_bloc.dart';

@immutable
class SelectionState {
  final bool isSelecting;
  final Set<int> selectedIds;

  const SelectionState({required this.isSelecting, required this.selectedIds});
}

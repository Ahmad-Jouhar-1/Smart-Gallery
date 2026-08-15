import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'selection_event.dart';
part 'selection_state.dart';

class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  SelectionBloc()
    : super(SelectionState(isSelecting: false, selectedIds: {})) {
    on<StartSelecting>((event, emit) {
      emit(SelectionState(isSelecting: true, selectedIds: {event.id}));
    });

    on<ToggleSelected>((event, emit) {
      final selectedIds = Set<int>.from(state.selectedIds);

      if (selectedIds.contains(event.id)) {
        selectedIds.remove(event.id);
      } else {
        selectedIds.add(event.id);
      }

      if (selectedIds.isEmpty) {
        emit(SelectionState(isSelecting: false, selectedIds: {}));
      } else {
        emit(SelectionState(isSelecting: true, selectedIds: selectedIds));
      }
    });

    on<SelectMany>((event, emit) {
      emit(
        SelectionState(isSelecting: event.ids.isNotEmpty, selectedIds: event.ids),
      );
    });

    on<ClearSelection>((event, emit) {
      emit(SelectionState(isSelecting: false, selectedIds: {}));
    });
  }
}

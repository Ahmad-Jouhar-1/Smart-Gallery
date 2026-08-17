import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_base_url_event.dart';
part 'fetch_base_url_state.dart';

class FetchBaseUrlBloc extends Bloc<FetchBaseUrlEvent, FetchBaseUrlState> {
  FetchBaseUrlBloc() : super(FetchBaseUrlInitial()) {
    on<BaseUrlIsFetched>((event, emit) {
      emit(
        FetchBaseUrlUpdate(
          baseUrl: event.baseUrl,
          isValid: event.baseUrl.isNotEmpty,
        ),
      );
    });
  }
}

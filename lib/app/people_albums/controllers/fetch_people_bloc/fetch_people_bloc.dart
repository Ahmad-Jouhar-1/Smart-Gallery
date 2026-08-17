import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/people_albums/models/person_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_people_event.dart';
part 'fetch_people_state.dart';

class FetchPeopleBloc extends Bloc<FetchPeopleEvent, FetchPeopleState> {
  FetchPeopleBloc() : super(FetchPeopleLoading()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<FetchPeople>((event, emit) async {
      emit(FetchPeopleLoading());

      try {
        final response = await api.get(EndPoints.personClusters);

        _people = (response as List<dynamic>)
            .map(
              (person) => PersonModel.fromJson(
                person as Map<String, dynamic>,
              ),
            )
            .toList();
        _filterPeople();

        _emitLoaded(emit);
      } on ServerException catch (e) {
        emit(FetchPeopleFailed(errorMessage: e.errorModel.errorMessage));
      }
    });

    on<SearchPeople>((event, emit) {
      _searchWord = event.searchWord.trim().toLowerCase();
      _filterPeople();

      _emitLoaded(emit);
    });

    on<PersonNameIsUpdated>((event, emit) {
      _people = _people
          .map(
            (person) => person.id == event.id
                ? person.copyWith(name: event.newName)
                : person,
          )
          .toList();
      _filterPeople();

      _emitLoaded(emit);
    });
  }

  List<PersonModel> _people = [];
  List<PersonModel> _visiblePeople = [];
  String _searchWord = '';

  void _filterPeople() {
    _visiblePeople = _searchWord.isEmpty
        ? List<PersonModel>.from(_people)
        : _people
              .where(
                (person) => person.name.toLowerCase().contains(_searchWord),
              )
              .toList();
  }

  void _emitLoaded(Emitter<FetchPeopleState> emit) {
    if (_people.isEmpty) {
      emit(FetchPeopleLoadedEmpty());
    } else {
      emit(FetchPeopleLoaded(people: _visiblePeople));
    }
  }
}

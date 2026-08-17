import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/people_albums/models/person_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'rename_person_event.dart';
part 'rename_person_state.dart';

class RenamePersonBloc extends Bloc<RenamePersonEvent, RenamePersonState> {
  RenamePersonBloc() : super(RenamePersonInitial()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<RenamePerson>((event, emit) async {
      final newName = event.newName.trim();

      if (newName.isEmpty) {
        emit(RenamePersonFailed(errorMessage: "Person name can't be empty."));
        return;
      }

      emit(RenamePersonLoading(personId: event.id));

      try {
        final response = await api.patch(
          EndPoints.person(event.id),
          data: {
            ApiKey.newName: newName,
          },
        );
        final person = PersonModel.fromJson(
          response as Map<String, dynamic>,
        );

        emit(RenamePersonLoaded(person: person));
      } on ServerException catch (e) {
        emit(RenamePersonFailed(errorMessage: e.errorModel.errorMessage));
      }
    });
  }
}

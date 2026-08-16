import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/image_evaluation/models/report_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportLoading()) {
    DioConsumer api = DioConsumer(dio: Dio());

    on<FetchReport>((event, emit) async {
      emit(ReportLoading());

      try {
        final response = await api.get(
          EndPoints.imageReport(event.imageId),
        );
        final report = ReportModel.fromJson(
          response as Map<String, dynamic>,
        );

        emit(ReportLoaded(report: report));
      } on ServerException catch (e) {
        emit(ReportFailed(errorMessage: e.errorModel.errorMessage));
      }
    });
  }
}

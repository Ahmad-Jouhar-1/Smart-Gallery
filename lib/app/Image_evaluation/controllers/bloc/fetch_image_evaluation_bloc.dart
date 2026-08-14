import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_gallery/app/Image_evaluation/models/image_evaluation_model.dart';
import 'package:smart_gallery/app/Image_evaluation/models/json_model.dart';
import 'package:smart_gallery/core/errors/exceptions.dart';

part 'fetch_image_evaluation_event.dart';
part 'fetch_image_evaluation_state.dart';

class FetchImageEvaluationBloc
    extends Bloc<FetchImageEvaluationEvent, FetchImageEvaluationState> {
  FetchImageEvaluationBloc() : super(FetchImageEvaluationLoading()) {
    on<FetchImageEvaluation>((event, emit) async {
      emit(FetchImageEvaluationLoading());
      try {
        await Future.delayed(Duration(seconds: 5));
        ImageEvaluationModel imageEvaluation = ImageEvaluationModel.fromJson(
          similarPhotosEvaluations[event.photoId] as Map<String, dynamic>,
        );
        emit(FetchImageEvaluationLoaded(imageEvaluation: imageEvaluation));
      } on ServerException catch (e) {
        emit(
          FetchImageEvaluationFailed(errorMessage: e.errorModel.errorMessage),
        );
      }
    });
  }
}

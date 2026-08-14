part of 'fetch_image_evaluation_bloc.dart';

@immutable
sealed class FetchImageEvaluationEvent {}

final class FetchImageEvaluation extends FetchImageEvaluationEvent {
  final int photoId;

  FetchImageEvaluation({required this.photoId});
}

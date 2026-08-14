part of 'fetch_image_evaluation_bloc.dart';

@immutable
sealed class FetchImageEvaluationState {}

final class FetchImageEvaluationLoading extends FetchImageEvaluationState {}

final class FetchImageEvaluationLoaded extends FetchImageEvaluationState {
  final ImageEvaluationModel imageEvaluation;

  FetchImageEvaluationLoaded({required this.imageEvaluation});
}

final class FetchImageEvaluationFailed extends FetchImageEvaluationState {
  final String errorMessage;

  FetchImageEvaluationFailed({required this.errorMessage});
}

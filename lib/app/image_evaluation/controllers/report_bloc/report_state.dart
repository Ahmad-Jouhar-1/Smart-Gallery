part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportLoading extends ReportState {}

final class ReportLoaded extends ReportState {
  final ReportModel report;

  ReportLoaded({required this.report});
}

final class ReportFailed extends ReportState {
  final String errorMessage;

  ReportFailed({required this.errorMessage});
}

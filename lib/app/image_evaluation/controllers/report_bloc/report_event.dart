part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

final class FetchReport extends ReportEvent {
  final int imageId;

  FetchReport({required this.imageId});
}

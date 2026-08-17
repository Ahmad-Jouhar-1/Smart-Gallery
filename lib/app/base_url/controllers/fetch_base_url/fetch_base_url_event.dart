part of 'fetch_base_url_bloc.dart';

@immutable
sealed class FetchBaseUrlEvent {}

final class BaseUrlIsFetched extends FetchBaseUrlEvent {
  final String baseUrl;

  BaseUrlIsFetched({required this.baseUrl});
}

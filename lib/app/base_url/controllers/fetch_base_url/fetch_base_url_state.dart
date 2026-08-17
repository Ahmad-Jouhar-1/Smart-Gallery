part of 'fetch_base_url_bloc.dart';

@immutable
sealed class FetchBaseUrlState {
  final String baseUrl;
  final bool isValid;

  const FetchBaseUrlState({required this.baseUrl, required this.isValid});
}

final class FetchBaseUrlInitial extends FetchBaseUrlState {
  const FetchBaseUrlInitial() : super(baseUrl: '', isValid: false);
}

final class FetchBaseUrlUpdate extends FetchBaseUrlState {
  const FetchBaseUrlUpdate({
    required super.baseUrl,
    required super.isValid,
  });
}

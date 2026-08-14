import 'package:dio/dio.dart';
import 'package:smart_gallery/core/api/end_points.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[ApiKey.accept] = "application/json";
    options.connectTimeout = Duration(seconds: 30);

    super.onRequest(options, handler);
  }
}

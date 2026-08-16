import 'package:dio/dio.dart';
import 'package:smart_gallery/core/api/end_points.dart';
import 'package:smart_gallery/core/services/shared_preferences/shared_preference_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[ApiKey.accept] = "application/json";
    options.connectTimeout = Duration(seconds: 30);
    final deviceIdentifier =
        await SharedPreferencesService.getDeviceIdentifier();
    if (deviceIdentifier != null) {
      options.headers[ApiKey.deviceIdentifier] = deviceIdentifier;
    }
    super.onRequest(options, handler);
  }
}

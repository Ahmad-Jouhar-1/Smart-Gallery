import 'package:dio/dio.dart';

import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage:
              "The connection took too long to establish. Please check your internet connection and try again.",
        ),
      );
    case DioExceptionType.sendTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage:
              "The request took too long to send. Please try again later.",
        ),
      );
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage:
              "The server took too long to respond. Please try again later.",
        ),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage:
              "There is a problem with the security certificate. Please ensure your connection is secure.",
        ),
      );
    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "The request was cancelled. Please try again.",
        ),
      );
    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage:
              "Failed to connect to the server. Please check your network and try again.",
        ),
      );
    case DioExceptionType.transformTimeout:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "An unexpected error occurred. Please try again later.",
        ),
      );
    case DioExceptionType.unknown:
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: "An unexpected error occurred. Please try again later.",
        ),
      );
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 401:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 403:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 404:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 409:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 422:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        case 504:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          );
        default:
          throw ServerException(
            errorModel: ErrorModel(
              errorMessage:
                  "Received invalid status code: ${e.response!.statusCode}",
            ),
          );
      }
  }
}

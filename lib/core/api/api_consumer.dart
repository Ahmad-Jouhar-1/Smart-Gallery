import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic> queryParameter,
    Options options,
  });

  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic> queryParameter,
    Options options,
    bool isFormData = false,
  });

  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic> queryParameter,
    Options options,
    bool isFormData = false,
  });

  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic> queryParameter,
    Options options,
    bool isFormData = false,
  });
}

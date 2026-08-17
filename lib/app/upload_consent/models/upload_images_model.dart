import 'dart:io';

import 'package:dio/dio.dart';

class UploadImagesModel {
  final List<File> files;
  final List<DateTime?> captureTimes;

  UploadImagesModel({required this.files, required this.captureTimes});

  Future<FormData> toFormData() async {
    final multipartFiles = await Future.wait(
      files.map(
        (file) => MultipartFile.fromFile(
          file.path,
          filename: file.uri.pathSegments.last,
        ),
      ),
    );

    return FormData.fromMap({
      'files': multipartFiles,
      'capture_times': captureTimes
          .map((captureTime) => captureTime?.toIso8601String())
          .toList(),
    });
  }
}
import 'package:dio/dio.dart';
import 'package:smart_gallery/app/upload_consent/models/upload_images_model.dart';
import 'package:smart_gallery/core/api/dio_consumer.dart';
import 'package:smart_gallery/core/api/end_points.dart';

class UploadImagesBatchService {
  Future<Map<String, dynamic>> uploadImages({
    required UploadImagesModel uploadImagesModel,
    ProgressCallback? onSendProgress,
  }) async {
    final dio = DioConsumer(dio: Dio());

    final response = await dio.post(
      EndPoints.uploadImages(),
      data: await uploadImagesModel.toFormData(),
      onSendProgress: onSendProgress,
    );

    return response as Map<String, dynamic>;
  }
}
import 'package:smart_gallery/core/api/end_points.dart';

class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    final message = jsonData[ApiKey.errorMessage];
    if (message is String && message.isNotEmpty) {
      return ErrorModel(errorMessage: message);
    }

    final detail = jsonData[ApiKey.detail];
    if (detail is String && detail.isNotEmpty) {
      return ErrorModel(errorMessage: detail);
    }

    if (detail is List) {
      final messages = detail
          .whereType<Map<String, dynamic>>()
          .map((error) => error[ApiKey.validationMessage]?.toString())
          .whereType<String>()
          .where((error) => error.isNotEmpty)
          .toList();

      if (messages.isNotEmpty) {
        return ErrorModel(errorMessage: messages.join('\n'));
      }
    }

    return ErrorModel(errorMessage: "An unexpected server error occurred.");
  }
}

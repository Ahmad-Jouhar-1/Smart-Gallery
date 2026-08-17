import 'package:smart_gallery/core/api/end_points.dart';

class PersonPhotoModel {
  final int id;
  final String image;
  final int rate;
  final bool isSelected;
  final DateTime? capturedAt;

  PersonPhotoModel({
    required this.id,
    required this.image,
    required this.rate,
    required this.isSelected,
    required this.capturedAt,
  });

  factory PersonPhotoModel.fromJson(Map<String, dynamic> jsonData) {
    return PersonPhotoModel(
      id: jsonData[ApiKey.id],
      image: jsonData[ApiKey.image],
      rate: (jsonData[ApiKey.rate] as num).toInt(),
      isSelected: jsonData[ApiKey.isSelected] ?? false,
      capturedAt: DateTime.tryParse(
        jsonData[ApiKey.captureTime]?.toString() ?? '',
      ),
    );
  }
}

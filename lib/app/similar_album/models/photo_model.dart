import 'package:smart_gallery/core/api/end_points.dart';

class PhotoModel {
  final int id;
  final String image;
  final int rate;
  final bool isSelected;

  PhotoModel({
    required this.id,
    required this.image,
    required this.rate,
    required this.isSelected,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> jsonData) {
    return PhotoModel(
      id: jsonData[ApiKey.id],
      image: jsonData[ApiKey.image],
      rate: jsonData[ApiKey.rate],
      isSelected: jsonData[ApiKey.isSelected],
    );
  }
}

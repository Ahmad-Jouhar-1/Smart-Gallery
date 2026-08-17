import 'package:smart_gallery/core/api/end_points.dart';

class DeleteResultModel {
  final int deletedCount;
  final List<int> deletedIds;
  final List<int> keptIds;
  final int remainingCount;

  DeleteResultModel({
    required this.deletedCount,
    required this.deletedIds,
    required this.keptIds,
    required this.remainingCount,
  });

  factory DeleteResultModel.fromJson(Map<String, dynamic> jsonData) {
    return DeleteResultModel(
      deletedCount: jsonData[ApiKey.deletedCount],
      deletedIds: (jsonData[ApiKey.deletedImageIds] as List<dynamic>)
          .map((id) => (id as num).toInt())
          .toList(),
      keptIds: (jsonData[ApiKey.keptImageIds] as List<dynamic>)
          .map((id) => (id as num).toInt())
          .toList(),
      remainingCount: jsonData[ApiKey.remainingImageCount],
    );
  }
}

import 'package:smart_gallery/app/similar_album/models/photo_model.dart';
import 'package:smart_gallery/core/api/end_points.dart';

class ClusterModel {
  final PhotoModel bestPhoto;
  final List<PhotoModel> photos;

  ClusterModel({required this.bestPhoto, required this.photos});

  factory ClusterModel.fromJson(Map<String, dynamic> jsonData) {
    return ClusterModel(
      bestPhoto: PhotoModel.fromJson(
        jsonData[ApiKey.bestPhoto] as Map<String, dynamic>,
      ),
      photos: (jsonData[ApiKey.allPhotos] as List<dynamic>)
          .map(
            (photo) => PhotoModel.fromJson(
              photo as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

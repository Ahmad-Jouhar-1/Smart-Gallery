import 'package:smart_gallery/app/person_album/models/person_photo_model.dart';
import 'package:smart_gallery/core/api/end_points.dart';

class PersonAlbumModel {
  final PersonPhotoModel bestPhoto;
  final List<PersonPhotoModel> photos;

  PersonAlbumModel({required this.bestPhoto, required this.photos});

  factory PersonAlbumModel.fromJson(Map<String, dynamic> jsonData) {
    return PersonAlbumModel(
      bestPhoto: PersonPhotoModel.fromJson(
        jsonData[ApiKey.bestPhoto] as Map<String, dynamic>,
      ),
      photos: (jsonData[ApiKey.allPhotos] as List<dynamic>)
          .map(
            (photo) => PersonPhotoModel.fromJson(
              photo as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

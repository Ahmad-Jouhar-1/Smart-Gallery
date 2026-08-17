class EndPoints {
  static String baseUrl = "http://10.49.15.202:8000";

  static void setBaseUrl(String newBaseUrl) {
    baseUrl = newBaseUrl;
  }

  static const String similarityClusters = '/similarity/clusters';

  static String cluster(int clusterId) {
    return '$similarityClusters/$clusterId';
  }

  static const String images = '/images';

  static const String deleteImages = '/images/batch';

  static String imageReport(int imageId) {
    return '$images/$imageId/report';
  }

  static const String registerDevice = '/devices/register';

  static const String personClusters = '/persons/clusters';

  static String person(int personId) {
    return '$personClusters/$personId';
  }

  static String uploadImages() {
    return '/images/upload-batch';
  }
}

class ApiKey {
  static String accept = "Accept";
  static String authorization = "Authorization";
  static String acceptLanguage = "Accept-Language";
  static String errorMessage = "message";
  static const String deviceIdentifier = 'device-identifier';
  static const String deviceIdentifierBody = 'device_identifier';
  static const String newName = 'new_name';
  static const String detail = 'detail';
  static const String validationMessage = 'msg';
  static const String bestPhoto = 'best_photo';
  static const String allPhotos = 'all_photos';
  static const String id = 'id';
  static const String image = 'image';
  static const String rate = 'rate';
  static const String isSelected = 'is_selected';
  static const String captureTime = 'capture_time';
  static const String images = 'images';
  static const String deletedCount = 'deleted_count';
  static const String deletedImageIds = 'deleted_image_ids';
  static const String keptImageIds = 'kept_image_ids';
  static const String remainingImageCount = 'remaining_image_count';
  static const String finalScore = 'final_score';
  static const String finalLevel = 'final_level';
  static const String lightingScore = 'lighting_score';
  static const String lightingLevel = 'lighting_level';
  static const String blurScore = 'blur_score';
  static const String blurLevel = 'blur_level';
  static const String bodyPositionScore = 'body_position_score';
  static const String bodyPositionLevel = 'body_position_level';
  static const String eyeOpenScore = 'eye_open_score';
  static const String eyeOpenLevel = 'eye_open_level';
  static const String finalReason = 'final_reason';
}

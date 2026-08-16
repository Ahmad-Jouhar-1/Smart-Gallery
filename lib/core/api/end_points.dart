class EndPoints {
  static String baseUrl = "http://192.168.1.2:8000";

  static void setBaseUrl(String newBaseUrl) {
    baseUrl = newBaseUrl;
  }

  static const String similarityClusters = '/similarity/clusters';

  static String cluster(int clusterId) {
    return '$similarityClusters/$clusterId';
  }

  static const String images = '/images';

  static String imageReport(int imageId) {
    return '$images/$imageId/report';
  }

  static const String registerDevice = '/devices/register';
}

class ApiKey {
  static String accept = "Accept";
  static String authorization = "Authorization";
  static String acceptLanguage = "Accept-Language";
  static String errorMessage = "message";
  static const String deviceIdentifier = 'device-identifier';
  static const String deviceIdentifierBody = 'device_identifier';
  static const String detail = 'detail';
  static const String validationMessage = 'msg';
  static const String bestPhoto = 'best_photo';
  static const String allPhotos = 'all_photos';
  static const String id = 'id';
  static const String image = 'image';
  static const String rate = 'rate';
  static const String isSelected = 'is_selected';
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

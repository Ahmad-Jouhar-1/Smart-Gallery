class ImageEvaluationModel {
  final int id;

  final int finalScore;
  final String finalLevel;

  final int lightingScore;
  final String lightingLevel;

  final int blurScore;
  final String blurLevel;

  final int bodyPositionScore;
  final String bodyPositionLevel;

  final int eyeOpenScore;
  final String eyeOpenLevel;

  final String finalReason;

  ImageEvaluationModel({
    required this.id,
    required this.finalScore,
    required this.finalLevel,
    required this.lightingScore,
    required this.lightingLevel,
    required this.blurScore,
    required this.blurLevel,
    required this.bodyPositionScore,
    required this.bodyPositionLevel,
    required this.eyeOpenScore,
    required this.eyeOpenLevel,
    required this.finalReason,
  });

  factory ImageEvaluationModel.fromJson(Map<String, dynamic> jsonData) {
    return ImageEvaluationModel(
      id: jsonData["id"],
      finalScore: jsonData["final_score"],
      finalLevel: jsonData["final_level"],
      lightingScore: jsonData["lighting_score"],
      lightingLevel: jsonData["lighting_level"],
      blurScore: jsonData["blur_score"],
      blurLevel: jsonData["blur_level"],
      bodyPositionScore: jsonData["body_position_score"],
      bodyPositionLevel: jsonData["body_position_level"],
      eyeOpenScore: jsonData["eye_open_score"],
      eyeOpenLevel: jsonData["eye_open_level"],
      finalReason: jsonData["final_reason"],
    );
  }
}

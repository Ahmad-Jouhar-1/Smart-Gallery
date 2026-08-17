import 'package:smart_gallery/core/api/end_points.dart';

class ReportModel {
  final int id;
  final int finalScore;
  final String finalLevel;
  final int lightingScore;
  final String lightingLevel;
  final int clarityScore;
  final String clarityLevel;
  final int bodyPositionScore;
  final String bodyPositionLevel;
  final int eyeOpenScore;
  final String eyeOpenLevel;
  final String finalReason;

  ReportModel({
    required this.id,
    required this.finalScore,
    required this.finalLevel,
    required this.lightingScore,
    required this.lightingLevel,
    required this.clarityScore,
    required this.clarityLevel,
    required this.bodyPositionScore,
    required this.bodyPositionLevel,
    required this.eyeOpenScore,
    required this.eyeOpenLevel,
    required this.finalReason,
  });

  factory ReportModel.fromJson(Map<String, dynamic> jsonData) {
    return ReportModel(
      id: jsonData[ApiKey.id],
      finalScore: (jsonData[ApiKey.finalScore] as num).toInt(),
      finalLevel: jsonData[ApiKey.finalLevel],
      lightingScore: (jsonData[ApiKey.lightingScore] as num).toInt(),
      lightingLevel: jsonData[ApiKey.lightingLevel],
      clarityScore: (jsonData[ApiKey.blurScore] as num).toInt(),
      clarityLevel: jsonData[ApiKey.blurLevel],
      bodyPositionScore: (jsonData[ApiKey.bodyPositionScore] as num).toInt(),
      bodyPositionLevel: jsonData[ApiKey.bodyPositionLevel],
      eyeOpenScore: (jsonData[ApiKey.eyeOpenScore] as num).toInt(),
      eyeOpenLevel: jsonData[ApiKey.eyeOpenLevel],
      finalReason: jsonData[ApiKey.finalReason],
    );
  }
}

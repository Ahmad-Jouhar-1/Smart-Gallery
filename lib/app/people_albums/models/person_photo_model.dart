class PersonPhotoModel {
  final int id;
  final String image;
  final int rate;
  final DateTime dateTime;

  PersonPhotoModel({
    required this.id,
    required this.image,
    required this.rate,
    required this.dateTime,
  });

  factory PersonPhotoModel.fromJson(
    Map<String, dynamic> jsonData, {
    required DateTime dateTime,
  }) => PersonPhotoModel(
    id: jsonData['id'],
    image: jsonData['image'],
    rate: jsonData['rate'],
    dateTime: dateTime,
  );
}

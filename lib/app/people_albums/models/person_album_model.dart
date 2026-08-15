class PersonAlbumModel {
  final int id;
  final String image;
  final String name;
  final int count;

  PersonAlbumModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
  });

  factory PersonAlbumModel.fromJson(Map<String, dynamic> jsonData) =>
      PersonAlbumModel(
        id: jsonData['id'],
        image: jsonData['image'],
        name: jsonData['name'],
        count: jsonData['count'],
      );
}

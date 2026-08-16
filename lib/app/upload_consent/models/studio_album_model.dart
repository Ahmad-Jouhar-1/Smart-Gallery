class StudioAlbumModel {
  final int id;
  final String image;
  final String name;
  final int count;

  StudioAlbumModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
  });

  factory StudioAlbumModel.fromJson(Map<String, dynamic> jsonData) =>
      StudioAlbumModel(
        id: jsonData['id'],
        image: jsonData['image'],
        name: jsonData['name'],
        count: jsonData['count'],
      );
}

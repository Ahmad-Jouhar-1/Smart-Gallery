class SimilarAlbumModel {
  final int id;
  final String image;
  final String name;
  final int count;

  SimilarAlbumModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
  });

  factory SimilarAlbumModel.fromJson(Map<String, dynamic> jsonData) {
    return SimilarAlbumModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      count: jsonData['count'],
    );
  }
}

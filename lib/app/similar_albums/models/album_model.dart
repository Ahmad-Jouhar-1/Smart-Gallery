class AlbumModel {
  final int id;
  final String image;
  final String name;
  final int count;

  AlbumModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> jsonData) {
    return AlbumModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      count: jsonData['count'],
    );
  }

  AlbumModel copyWith({String? name}) {
    return AlbumModel(
      id: id,
      image: image,
      name: name ?? this.name,
      count: count,
    );
  }
}

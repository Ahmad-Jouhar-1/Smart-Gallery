class SimilarAlbumPhotoModel {
  final int id;
  final String image;
  final int rate;
  final bool isSelected;

  SimilarAlbumPhotoModel({
    required this.id,
    required this.image,
    required this.rate,
    required this.isSelected,
  });

  factory SimilarAlbumPhotoModel.fromJson(Map<String, dynamic> jsonData) {
    return SimilarAlbumPhotoModel(
      id: jsonData['id'],
      image: jsonData['image'],
      rate: jsonData['rate'],
      isSelected: jsonData['is_selected'],
    );
  }
}

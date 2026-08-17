class PersonModel {
  final int id;
  final String image;
  final String name;
  final int count;

  PersonModel({
    required this.id,
    required this.image,
    required this.name,
    required this.count,
  });

  factory PersonModel.fromJson(Map<String, dynamic> jsonData) {
    return PersonModel(
      id: jsonData['id'],
      image: jsonData['image'],
      name: jsonData['name'],
      count: jsonData['count'],
    );
  }

  PersonModel copyWith({String? name}) {
    return PersonModel(
      id: id,
      image: image,
      name: name ?? this.name,
      count: count,
    );
  }
}

class ExcersiceModel {
  final String id;
  final String name;
  final String image;
  final String link;

  ExcersiceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.link,
  });
  factory ExcersiceModel.fromJson(Map<String, dynamic> json) {
    return ExcersiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      link: json['link'] ?? '',
    );
  }
}

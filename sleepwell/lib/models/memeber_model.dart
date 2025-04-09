class MemeberModel {
  final String id;
  final String name;
  final String image;
  final String roles;
  final String major;

  MemeberModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.roles,
      required this.major});
  factory MemeberModel.fromJson(Map<String, dynamic> json) {
    return MemeberModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      roles: json['roles'] ?? '',
      major: json['major'] ?? '',
    );
  }
}

class MusicModel {
  final String id;
  final String name;
  final String image;
  final String link;
  final String singer;
  MusicModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.link,
      required this.singer});
  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      link: json['link'] ?? '',
      singer: json['singer'] ?? '',
    );
  }
}

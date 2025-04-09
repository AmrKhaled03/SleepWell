class BooksModel {
  final String id;
  final String name;
  final String image;
  final String link;
  final String author;
  final String description;
  final String type;
  BooksModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.link,
      required this.author,
      required this.description,
      required this.type
      });
  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
        id: json['id'],
        name: json['name'] ?? '',
        image: json['image'] ?? '',
        link: json['link'] ?? '',
        author: json['author'] ?? '',
        description: json['description'] ?? '',
        type: json['type'] ?? ''

        
        );
  }
}

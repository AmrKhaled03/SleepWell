class UserRating {
  final int id;
  final int userId;
  final int recommendationId;
  final dynamic rating;
  final String createdAt;

  UserRating({
    required this.id,
    required this.userId,
    required this.recommendationId,
    required this.rating,
    required this.createdAt,
  });

  factory UserRating.fromJson(Map<String, dynamic> json) {
    return UserRating(
      id: json['id'],
      userId: json['user_id'],
      recommendationId: json['recommendation_id'],
      rating: json['rating'],
      createdAt: json['created_at'],
    );
  }
}

class UserFeedback {
  final int id;
  final int userId;
  final int recommendationId;
  final String feedback;
  final String createdAt;

  UserFeedback({
    required this.id,
    required this.userId,
    required this.recommendationId,
    required this.feedback,
    required this.createdAt,
  });

  factory UserFeedback.fromJson(Map<String, dynamic> json) {
    return UserFeedback(
      id: json['id'],
      userId: json['user_id'],
      recommendationId: json['recommendation_id'],
      feedback: json['feedback'],
      createdAt: json['created_at'],
    );
  }
}

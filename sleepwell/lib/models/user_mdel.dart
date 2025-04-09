class UserMdel {
  dynamic id;
  dynamic email;
  dynamic username;
  dynamic role;
  dynamic image;
  dynamic specialization;
  dynamic appointmentImage;
  String? startDate;
  String? endDate;
  String? description;

  UserMdel(
      {required this.id,
      required this.email,
      required this.username,
      required this.role,
      required this.image,
      this.specialization,
      this.appointmentImage,
      this.startDate,
      this.endDate,
      this.description});

  void updateProfile({
    required String username,
    required String email,
    String? image,
    String? specialization,
    String? appointmentImage,
    String? startDate,
    String? endDate,
    String? description,
  }) {
    this.username = username;
    this.email = email;
    if (image != null) {
      this.image = image;
    }
    if (specialization != null) {
      this.specialization = specialization;
    }
    if (description != null) {
      this.description = description;
    }
    if (appointmentImage != null) {
      this.appointmentImage = appointmentImage;
    }
    if (startDate != null) {
      this.startDate = startDate;
    }
    if (endDate != null) {
      this.endDate = endDate;
    }
  }

  factory UserMdel.fromJson(Map<String, dynamic> json) {
    return UserMdel(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        role: json['role'] ?? 'patient',
        image: json['profile_image'] ?? '',
        specialization: json['specialization'] ?? "Therapist",
        appointmentImage: json['appointment_image'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'image': image,
      'specialization': specialization,
      'appointment_image': appointmentImage,
      'start_date': startDate,
      'end_date': endDate,
      'description': description
    };
  }
}

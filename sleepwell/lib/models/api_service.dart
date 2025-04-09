import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/models/user_feedback.dart';
import 'package:sleepwell/models/user_mdel.dart';
import 'package:sleepwell/models/user_rating.dart';

class ApiService {
  final String baseUrl = 'http://localhost/grad';

  Future<UserMdel?> loginWithEmail(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    debugPrint("Login Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return UserMdel.fromJson(data['user']);
      } else {
        debugPrint(data['message']);
                return null;

      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>?> registerUser(String username, String email,
      String password, String confirmPassword, String role) async {
    final url = Uri.parse('$baseUrl/register.php');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
          'role': role,
        }));

    debugPrint("Registration Response: ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      debugPrint(
          "Failed to register. Status Code: ${response.statusCode}, Response Body: ${response.body}");
      return null;
    }
  }



  Future<UserMdel?> googleLogin(String googleId, String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/google-login.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'google_id': googleId, 'email': email}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          return UserMdel.fromJson(data['user']);
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to log in with Google');
      }
    } catch (e) {
      debugPrint("Network error: $e");
      rethrow;
    }
  }



  Future<void> addFeedback(UserFeedback feedback, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/feedback.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'recommendation_id': feedback.recommendationId,
          'feedback': feedback.feedback,
        }),
      );
      debugPrint('Add feedback Data Response: ${response.body}');

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode != 200 || !jsonResponse['success']) {
        final errorMessage =
            jsonResponse['message'] ?? 'Failed to add sleep data';
        debugPrint("Add feedback Data Error: $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint("Add feedback Data Exception: $e");
      throw Exception('Failed to add sleep data due to network error');
    }
  }

  Future<void> addRating(UserRating rating, int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/save_rating.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'recommendation_id': rating.recommendationId,
          'rating': rating.rating,
        }),
      );
      debugPrint('Add rating Data Response: ${response.body}');

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode != 200 || !jsonResponse['success']) {
        final errorMessage =
            jsonResponse['message'] ?? 'Failed to add sleep data';
        debugPrint("Add feedback Data Error: $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint("Add feedback Data Exception: $e");
      throw Exception('Failed to add sleep data due to network error');
    }
  }

  Future<bool> updateProfile(
      {required int userId,
      required String username,
      required String email,
      required String role,
      String? imageUrl,
      File? appointmentImage,
      String? specialization,
      String? startDate,
      String? endDate,
      String? description}) async {
    try {
      var uri = Uri.parse('$baseUrl/update_profile.php');
      var request = http.MultipartRequest('POST', uri)
        ..fields['id'] = userId.toString()
        ..fields['username'] = username
        ..fields['email'] = email
        ..fields['role'] = role;

      if (specialization != null) {
        request.fields['specialization'] = specialization;
      }
      if (description != null) {
        request.fields['description'] = description;
      }
      request.fields['start_time'] =
          startDate != null && startDate.isNotEmpty ? startDate : "00:00:00";
      request.fields['end_time'] =
          endDate != null && endDate.isNotEmpty ? endDate : "00:00:00";

      if (appointmentImage != null) {
        var appointmentFile = await http.MultipartFile.fromPath(
            'appointment_image', appointmentImage.path);
        request.files.add(appointmentFile);
      }

      if (imageUrl != null) {
        request.fields['profile_image'] = imageUrl;
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        debugPrint("Response: $responseBody");
        return true;
      } else {
        debugPrint("Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return false;
    }
  }
}

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/models/user_mdel.dart';
import 'package:sleepwell/models/user_feedback.dart';
import 'package:sleepwell/models/user_rating.dart';
import '../models/api_service.dart';

class FeedbackController extends GetxController {
  final List<UserFeedback> feedbackList = [];
  UserMdel? user;
  bool isRatingSubmitted = false;
  double rating = 0;
  final String apiUrl =
      'http://localhost/grad/save_rating.php'; // رابط الـ API الخاص بك

  Future<void> checkRating(int userId, int recommendationId) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$apiUrl/check_rating.php?user_id=$userId&recommendation_id=$recommendationId'),
      );

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200 && jsonResponse['success']) {
        isRatingSubmitted = true; // التقييم موجود بالفعل
      } else {
        isRatingSubmitted = false; // التقييم غير موجود
      }
    } catch (e) {
      debugPrint("Check Rating Exception: $e");
    }
  }

  void addFeedback(UserFeedback feedback) async {
    user = Get.arguments;
    if (user == null || user!.id == null) {
      throw Exception("User ID is null");
    }

    final apiService = ApiService();

    try {
      showAwesomeDialog(
        dialogType: DialogType.success,
        title: "Success ✅",
        desc: "Feedback submitted successfully!",
      );

      await apiService.addFeedback(feedback, user!.id);

      update();
    } catch (error) {
      showAwesomeDialog(
        dialogType: DialogType.error,
        title: "Error ❌",
        desc: "Failed to submit feedback: $error",
      );
    }
  }

  void addRating(UserRating rating) async {
    user = Get.arguments;
    if (user == null || user!.id == null) {
      throw Exception("User ID is null");
    }

    final apiService = ApiService();

    try {
      showAwesomeDialog(
        dialogType: DialogType.success,
        title: "Success ✅",
        desc: "Rating Submitted Successfully!",
      );

      await apiService.addRating(rating, user!.id);

      update();
    } catch (error) {
      showAwesomeDialog(
        dialogType: DialogType.error,
        title: "Error ❌",
        desc: "Failed to submit rating: $error",
      );
    }
  }

  void showAwesomeDialog({
    required DialogType dialogType,
    required String title,
    required String desc,
  }) {
    AwesomeDialog(
      context: Get.overlayContext!,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      autoHide: const Duration(seconds: 3),
    ).show();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/models/meal_model.dart';

class FoodDetailsController extends GetxController {
  bool isLoading = false;
  MealModel? meal;

  Future<void> fetchMealDetails(String mealId) async {
    isLoading = true;
    update();

    try {
      final url = Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['meals'] != null && data['meals'].isNotEmpty) {
          meal = MealModel.fromJson(data['meals'][0]);
        } else {
          debugPrint("Error: No meal data found");
        }
      } else {
        debugPrint(
            "Error: API request failed with status ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching meal details: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is MealModel) {
      meal = Get.arguments as MealModel;

      if (meal != null && meal!.idMeal.isNotEmpty) {
        fetchMealDetails(meal!.idMeal);
      } else {
        debugPrint("Error: Meal ID is missing");
      }
    } else {
      debugPrint("Error: MealModel data is missing");
    }
  }
}

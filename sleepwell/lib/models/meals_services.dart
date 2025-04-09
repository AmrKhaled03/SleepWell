import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/models/meal_model.dart';

class MealsServices {
  Future<List<MealModel>> fetchBreakfast() async {
    return await fetchMealsByCategory("Breakfast");
  }

  Future<List<MealModel>> fetchLunch() async {
    return await fetchMealsByCategory("Beef");
  }

  Future<List<MealModel>> fetchDinner() async {
    return await fetchMealsByCategory("Chicken");
  }

  Future<List<MealModel>> fetchMealsByCategory(String category) async {
    try {
      final url = Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> result = data['meals'];
        return result.map((meal) => MealModel.fromJson(meal)).toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching meals: $e");
      return [];
    }
  }
}

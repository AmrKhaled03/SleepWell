import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/models/meal_model.dart';
import 'package:sleepwell/models/meals_services.dart';

class MealsController extends GetxController {
  List<MealModel> breakfastMeals = [];
  List<MealModel> lunchMeals = [];
  List<MealModel> dinnerMeals = [];
  MealsServices mealsServices = MealsServices();
  bool isLoading = false;
  void checkMeals() async {
    isLoading = true;
    update();
    try {
      var breakfast = await mealsServices.fetchBreakfast();
      var lunch = await mealsServices.fetchLunch();
      var dinner = await mealsServices.fetchDinner();

      breakfastMeals.assignAll(breakfast);
      breakfastMeals.shuffle();
      debugPrint(breakfastMeals.length.toString());
      lunchMeals.assignAll(lunch);
      lunchMeals.shuffle();
      debugPrint(lunchMeals.length.toString());

      dinnerMeals.assignAll(dinner);
      dinnerMeals.shuffle();
      debugPrint(dinnerMeals.length.toString());

      update();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    checkMeals();
    super.onInit();
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/models/meal_model.dart';

class CustomWidget extends StatelessWidget {
  final List<MealModel> meals;
  const CustomWidget({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: meals.map((meal) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: meal.idMeal,
                child: Image.network(
                  meal.strMealThumb,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppStrings.foodDetailsRoute, arguments: meal);
                },
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    meal.strMeal,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

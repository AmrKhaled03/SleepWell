import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/meals_controller.dart';
import 'package:sleepwell/views/custom_widget.dart';

class HealthyFoodScreen extends GetWidget<MealsController> {
  const HealthyFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AppTranslations>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Text(
          AppTranslations.translate("healthyFood",args:[]),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<MealsController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(color: AppColors.arrowColor),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Breakfast",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        CustomWidget(meals: controller.breakfastMeals),
                        const SizedBox(height: 30),
                        Text(
                          "Lunch",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomWidget(meals: controller.lunchMeals),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Dinner",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomWidget(meals: controller.dinnerMeals),
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }
}

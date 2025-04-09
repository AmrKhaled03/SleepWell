import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/food_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDetails extends GetWidget<FoodDetailsController> {
  const FoodDetails({super.key});

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
          AppTranslations.translate("foodDetails", args: []),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<FoodDetailsController>(
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
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Hero(
                            tag: controller.meal!.idMeal,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                    controller.meal!.strMealThumb))),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.meal!.strMeal,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppTranslations.translate("steps",args:[]),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                controller.meal!.strInstructions,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppTranslations.translate("ingredients",args:[]),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ...controller.meal!.ingredients.map((ingredient) {
                                return Text(
                                  " ${ingredient['measure']} ${ingredient['ingredient']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                );
                              }),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                              
                      '${AppTranslations.translate("country", args: [])}:${controller.meal!.strArea}',

                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final Uri url =
                                        Uri.parse(controller.meal!.strYoutube);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      Get.snackbar("Error",
                                          "Could not open YouTube link");
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.video_library,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  label: Text(
                                    AppTranslations.translate("watchYoutube",args:[]),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    final Uri url =
                                        Uri.parse(controller.meal!.strSource);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      Get.snackbar("Error",
                                          "Could not open source link");
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  label: Text(
                                    AppTranslations.translate("viewSource",args:[]),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }
}

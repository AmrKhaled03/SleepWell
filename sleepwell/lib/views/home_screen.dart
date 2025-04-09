import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<AuthController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    Get.find<AppTranslations>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: GetBuilder<AuthController>(
          init: authController,
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppStrings.profileRoute,
                            arguments: authController.user);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.containerColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppTranslations.translate("account",args:[]),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  AssetImage("assets/images/image_account.png"),
                              backgroundColor: AppColors.arrowColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.libraryRoute);
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.otherContainerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/library_logo.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTranslations.translate("library",args:[]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.meditationRoute);
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.otherContainerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/meditation.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTranslations.translate("meditation",args:[]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.medicalRoute);
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.otherContainerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/chatbot_logo.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTranslations.translate("chatbot",args:[]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.foodRoute);
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.otherContainerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/food_logo.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTranslations.translate("healthyFood",args:[]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.chatRoute);
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.otherContainerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/doctor.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTranslations.translate("doctorChat",args:[]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Get.toNamed(AppStrings.feedbackRoute,
                                arguments: controller.user);
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.otherContainerColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/feedback_logo.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTranslations.translate("feedback",args:[]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppStrings.aboutRoute,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.containerColor),
                        child: Text(
                          AppTranslations.translate("aboutUs",args:[]),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

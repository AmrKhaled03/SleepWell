import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/auth_controller.dart';

class DoctorHomeScreen extends GetWidget<AuthController> {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AppTranslations>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GetBuilder<AuthController>(
              builder: (authController) {
                return Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(

                      '${AppTranslations.translate("welcomeDoctor", args: [])}:${authController.user.username.toString().toUpperCase()}',

                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppStrings.doctorProfileRoute,
                            arguments: authController.user);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.containerColor),
                        child:  Row(
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
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppStrings.chatPageDocRoute);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.containerColor),
                        child: Text(
                                                                          AppTranslations.translate("chats",args:[]),

                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';

class SelectScreen extends GetWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AppTranslations>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/undraw_Login.png",
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppTranslations.translate("selectGate", args: []),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.arrowColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      label: Text(
                        AppTranslations.translate("doctor", args: []),
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.toNamed(AppStrings.registerRoute,
                            arguments: "doctor");
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.arrowColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      label: Text(
                        AppTranslations.translate("patient", args: []),
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.toNamed(AppStrings.registerRoute,
                            arguments: "patient");
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: Text(
                        AppTranslations.translate("login", args: []),
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.toNamed(AppStrings.loginRoute);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 24,
                      ),
                      label: Text(
                        AppTranslations.translate("settings", args: []),
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Get.toNamed(AppStrings.settingsRoute);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

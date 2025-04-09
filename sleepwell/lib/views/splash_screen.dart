import 'package:lottie/lottie.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    Future.delayed(const Duration(seconds: 3), () {
      if (authController.user.email != null &&
          authController.user.email.isNotEmpty &&
          authController.user.username != null) {
        if (authController.user.role == 'patient') {
          Get.offAllNamed(AppStrings.homeRoute);
        } else if (authController.user.role == 'doctor') {
          Get.offAllNamed(AppStrings.doctorHomeRoute);
        }
      } else {
        Get.offNamed(AppStrings.onboardOneRoute);
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Lottie.asset("assets/jsons/Logo-1-[remix].json")],
          ),
        ),
      ),
    );
  }
}

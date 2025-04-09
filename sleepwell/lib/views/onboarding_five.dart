import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';

class OnboardingFive extends StatelessWidget {
  const OnboardingFive({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Image.asset(
              "assets/images/healthyFood.png",
              height: 300,
            ),
            Text(
              "Healthy Lifestyle",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "A nurturing life-action plan designed to seamlessly integrate into your daily activities while putting your mental health first."
              "By leveraging specially curated guidelines, you can unlock the treasures of physical activity, nutritious eating habits, and mindfulness, fostering a holistic sense of well-being.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Get.offAllNamed(AppStrings.selectRoute);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                                width: 150,

                ),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          Get.offNamed(AppStrings.onboardPayRoute);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                          size: 50,
                        )))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

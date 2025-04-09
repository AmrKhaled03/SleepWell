import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

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
            Image.asset("assets/images/OBJECTS.png",height: 300,),


            Text(
              "  ${AppStrings.appTitle} Library",
              textAlign: TextAlign.center,

              style: TextStyle(

                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "A unique library designed for mental discovery, offering books that guide your mind to new perspectives, ease challenges, and promote relaxation",
              textAlign: TextAlign.center,
              style: TextStyle(

                  color: Colors.white,
                  fontSize: 25,
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
                          Get.offNamed(AppStrings.onboardThreeRoute);
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

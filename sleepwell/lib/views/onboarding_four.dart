import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';

class OnboardingFour extends StatelessWidget {
  const OnboardingFour({super.key});

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
                "assets/images/Meditation_pose_by_Worldatstickers___Redbubble-removebg-preview.png",height: 300,),


            Text(
              "Meditation And Relaxation ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Embark on a journey of self-discovery with mindfulness sessions to refresh your mind, reduce stress,and enhance relaxation as part of your recovery routine" ,
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 50,),
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
                          Get.offNamed(AppStrings.onboardFiveRoute);
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
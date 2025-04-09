import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';

class OnboardingSix extends StatelessWidget {
  const OnboardingSix({super.key});

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
            Image.asset("assets/images/Get_a_Brief_Intro_about_the_Online_AI_Chatbot_Solution-removebg-preview.png",height: 300,),


            Text(
              "Chatbot",
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),

            Text(
              "Our chat bot helps identify your insomnia level,"
              "offering insights and guidance to improve"
              "your sleep and well-being.",
              textAlign: TextAlign.center,
            
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.startedColor)),
                  onPressed: () {
                    Get.offAllNamed(AppStrings.selectRoute);
                  },
                  
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}

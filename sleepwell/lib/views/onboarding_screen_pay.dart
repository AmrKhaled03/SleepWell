import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';

class OnboardingScreenPay extends StatelessWidget {
  const OnboardingScreenPay({super.key});

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
              "assets/images/Download_E_wallet__digital_payment__online_transaction_with_woman_standing_and_holding_mobile_phone_concept_illustration_for_free-removebg-preview.png",
              height: 300,
            ),
            Text(
              "Payment Required",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "To enable chat with the doctor, you need to make a payment of 50 pounds. This will allow you to access professional advice and support.",
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
                          Get.offNamed(AppStrings.onboardSixRoute);
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/payment_controller.dart';

class PaymentScreen extends GetWidget<PaymentController> {
  const PaymentScreen({super.key});

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
            AppTranslations.translate("payment",args:[]),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<PaymentController>(
          builder: (controller) {
            return controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 20),

                        Center(child: _buildCardField()),
                        SizedBox(height: 20),
                        Center(child: _buildExpiryAndCvvField()),
                        SizedBox(height: 20),
                        _buildPayButton(context),
                        // Center(
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width,
                        //     child: ElevatedButton(
                        //       style: ButtonStyle(
                        //           backgroundColor:
                        //               WidgetStatePropertyAll(Colors.green)),
                        //       onPressed: () => _showConfirmDialog(context),
                        //       child: Text(
                        //         " Pay Now",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 24,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildCardField() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller.cardNumberController,
      maxLength: 19,
      decoration: InputDecoration(
        labelText: "Card Number",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "1234 5678 9012 3456",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildExpiryAndCvvField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller.expiryDateController,
            maxLength: 5,
            decoration: InputDecoration(
              labelText: "MM/YY",
              labelStyle: TextStyle(color: Colors.white),
              hintText: "MM/YY",
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            controller: controller.cvvController,
            maxLength: 3,
            decoration: InputDecoration(
              labelText: "CVV",
              labelStyle: TextStyle(color: Colors.white),
              hintText: "123",
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () => _showConfirmDialog(context),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 11, 149, 15)),
          child: Text(
                      AppTranslations.translate("payNow",args:[]),

            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Confirm Payment",
      titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      middleText:
          "Are you sure you want to proceed with the payment?\n\nYou will pay 50 pounds to talk to Dr",
      middleTextStyle: const TextStyle(fontSize: 18),
      textCancel: "Cancel",
      textConfirm: "Yes, Pay",
      confirmTextColor: Colors.white,
      buttonColor: Colors.green,
      onConfirm: () {
        Get.back();
        controller.processPayment(); // Proceed with payment
      },
    );
  }
}

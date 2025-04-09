import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/controllers/chat_controller.dart';

class PaymentController extends GetxController {
  dynamic doctorId;
  dynamic patientId;
  bool isLoading = false;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      doctorId = args['doctorId'];
      patientId = args['patientId'];
    }
  }

  Future<void> processPayment() async {
    if (doctorId == null || patientId == null) {
      Get.snackbar('خطأ', 'بيانات الطبيب أو المريض غير متوفرة.');
      return;
    }
    isLoading = true;
    update();
    try {
      final response = await http.post(
        Uri.parse('http://localhost/grad/save_payment.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'patient_id': patientId, 'doctor_id': doctorId}),
      );
      String cardNumber = cardNumberController.text;
      String expiryDate = expiryDateController.text;
      String cvv = cvvController.text;

      debugPrint('Card Number: $cardNumber');
      debugPrint('Expiry Date: $expiryDate');
      debugPrint('CVV: $cvv');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          update();
          showDialogBox(DialogType.success, "Success",
              "Payment completed successfully 🎉");

          Future.delayed(const Duration(seconds: 2), () {
            Get.back();
          });

          ChatController chatController = Get.find<ChatController>();
          await chatController.checkPaymentStatus();
        } else {
          showDialogBox(DialogType.warning, "Failed",
              "Payment saving failed: ${data['error']}");
        }
      } else {
        showDialogBox(
            DialogType.error, "Error", "Failed to connect to the server.");
      }
    } catch (e) {
      showDialogBox(
          DialogType.error, "Error", "An error occurred during payment: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  void showDialogBox(DialogType dialogType, String title, String desc) {
    AwesomeDialog(
      context: Get.overlayContext!,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      autoHide: const Duration(seconds: 3),
    ).show();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/models/firebase_services.dart';
import 'package:sleepwell/models/memeber_model.dart';

class AboutController extends GetxController {
  bool isLoading = false;
  List<MemeberModel> members = [];
  FirebaseServices firebaseServices = FirebaseServices();

  Future<void> validateData() async {
    isLoading = true;
    update();
    try {
      members.assignAll(await firebaseServices.getMembers());
      debugPrint('Exercises count: ${members.length}');
      update();
    } catch (e) {
      debugPrint("Error Fetching");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    validateData();
    super.onInit();
  }
}

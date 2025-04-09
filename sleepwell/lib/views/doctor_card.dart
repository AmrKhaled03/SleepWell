import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/chat_controller.dart';

class DoctorCard extends GetWidget<ChatController> {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic doctor = Get.arguments;
    Get.find<AppTranslations>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.arrowColor),
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
            Center(
              child: Column(
                spacing: 20,
                children: [
                  Hero(
                    tag: doctor['id'],
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey.shade200,
                      child: ClipOval(
                        child: doctor['profile_image'] == null ||
                                doctor['profile_image'] == ''
                            ? Image.asset("assets/images/doctor.png")
                            : Image.network(
                                doctor['profile_image'],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.person,
                                      size: 50, color: Colors.grey);
                                },
                              ),
                      ),
                    ),
                  ),
                  Text(


                      '${AppTranslations.translate("doctorUsername", args: [])}:${doctor['username']}',

                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(

                      '${AppTranslations.translate("doctorSpecialization", args: [])}:${doctor['specialization']??"Therapist"}',

                    // " Specialization / ${doctor['specialization'] ?? "Therapist"}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    doctor['description'].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(

                      '${AppTranslations.translate("doctorStart", args: [])}:${doctor['start_time']}',

                    // " Start At / ${doctor['start_time']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(

                      '${AppTranslations.translate("doctorEnd", args: [])}:${doctor['end_time']}',

                    // " End At / ${doctor['end_time']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        _startChat(context, doctor);
                      },
                      icon: Icon(
                        Icons.message_outlined,
                        color: Colors.white,
                        size: 100,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void _startChat(BuildContext context, Map<String, dynamic> doctor) async {
    controller.setCurrentDoctorId(doctor['id']);
    ChatController chatController = Get.find<ChatController>();
    bool isPaid = await chatController.checkPaymentStatus();

    if (isPaid) {
      Get.toNamed(
        AppStrings.chatPagePatRoute,
        arguments: doctor,
      );
    } else {
      Get.toNamed(
        AppStrings.payRoute,
        arguments: {
          'doctorId': doctor['id'],
          'patientId': chatController.currentPatientId
        },
      );
    }
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/auth_controller.dart';
import 'package:sleepwell/controllers/profile_controller.dart';

class DoctorProfileScreen extends GetView<ProfileController> {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController =
        TextEditingController(text: controller.user!.username);
    TextEditingController emailController =
        TextEditingController(text: controller.user!.email);
    TextEditingController specializationController =
        TextEditingController(text: controller.user!.specialization);
    TextEditingController descriptionController =
        TextEditingController(text: controller.user!.description);
    AuthController authController = Get.find<AuthController>();

    File? appointmentImage;
    TimeOfDay? parseTimeOfDay(String? timeString) {
      if (timeString == null || timeString.isEmpty) return null;

      try {
        List<String> parts = timeString.split(':');
        if (parts.length != 2) return null;

        int hour = int.tryParse(parts[0]) ?? 0;
        int minute = int.tryParse(parts[1]) ?? 0;

        return TimeOfDay(hour: hour, minute: minute);
      } catch (e) {
        debugPrint("Error parsing time: $e");
        return null;
      }
    }

    TimeOfDay? startTime = parseTimeOfDay(controller.user?.startDate);
    TimeOfDay? endTime = parseTimeOfDay(controller.user?.endDate);

    Future<void> selectTime(BuildContext context, bool isStartTime) async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        if (isStartTime) {
          startTime = pickedTime;
        } else {
          endTime = pickedTime;
        }
        controller.update();
      }
    }

    Get.find<AppTranslations>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title:  Text(
                                                                AppTranslations.translate("doctorProfile",args:[]),

            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<ProfileController>(
          builder: (profileController) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
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
                      if (profileController.isLoading)
                        Center(child: const CircularProgressIndicator()),
                      if (!profileController.isLoading) ...[
                        Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipOval(
                              child: controller.user!.image != null &&
                                      controller.user!.image != '' &&
                                      controller.user!.image!.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        controller.pickImage();
                                      },
                                      child: Image.network(
                                        controller.user!.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        controller.pickImage();
                                      },
                                      icon: const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 50),
                                    ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:                                                                 AppTranslations.translate("hintUsername",args:[]),

                              labelText:   AppTranslations.translate("hintUsername",args:[]),
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        TextField(
                          controller: emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:   AppTranslations.translate("hintEmail",args:[]),
                              labelText:   AppTranslations.translate("hintEmail",args:[]),
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        TextField(
                          controller: specializationController,
                          style: const TextStyle(color: Colors.white),
                          decoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:   AppTranslations.translate("hintSpecialization",args:[]),
                              labelText:   AppTranslations.translate("hintSpecialization",args:[]),
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        TextField(
                          controller: descriptionController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText:  AppTranslations.translate("labelDescription",args:[]),
                              hintText:AppTranslations.translate("hintDescription",args:[]),
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(color: Colors.white),
                              hintStyle: TextStyle(color: Colors.white)),
                          maxLines: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => selectTime(context, true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  startTime != null
                                      ? "Start Time: ${startTime!.format(context)}"
                                      : "Select Start Time",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () => selectTime(context, false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  endTime != null
                                      ? "End Time: ${endTime!.format(context)}"
                                      : "Select End Time",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            profileController.updateProfile(
                                userId: profileController.user!.id,
                                username: usernameController.text,
                                role: profileController.user!.role,
                                email: emailController.text,
                                image: profileController.selectedImage,
                                appointmentImage: appointmentImage,
                                specialization: specializationController.text,
                                startDate: startTime.toString(),
                                endDate: endTime.toString(),
                                description: descriptionController.text);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.btnUpdate),
                            child:  Text(
                            AppTranslations.translate("update",args:[]),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            authController.logout();
                            Get.offAllNamed(AppStrings.loginRoute);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.btnLogout),
                            child:  Text(
                            AppTranslations.translate("logout",args:[]),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                                  const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    label:  Text(
                      AppTranslations.translate("settings",args:[]),
                      style: TextStyle(fontSize: 24, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Get.toNamed(AppStrings.settingsRoute);
                    },
                  ),
                ),
                      ],
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

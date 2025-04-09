import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/chat_controller.dart';

class PatientChatScreen extends GetWidget<ChatController> {
  const PatientChatScreen({super.key});

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
            AppTranslations.translate("chatWith",args:[]),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<ChatController>(
                  builder: (controller) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: controller.doctors.length,
                      itemBuilder: (context, index) {
                        var doctor = controller.doctors[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: Hero(
                              tag: doctor['id'],
                              child: CircleAvatar(
                                backgroundImage:
                                    doctor['profile_image'] == '' ||
                                            doctor['profile_image'] == null
                                        ? AssetImage("assets/images/doctor.png")
                                        : NetworkImage(
                                            '${doctor['profile_image']}'),
                              ),
                            ),
                            title: Text(doctor['username']),
                            subtitle:
                                Text(doctor['specialization'] ?? "Therapist"),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // _showDoctorDialog(context, doctor);
                                Get.toNamed(AppStrings.cardRoute,
                                    arguments: doctor);
                              },
                              child: const Text('Details'),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

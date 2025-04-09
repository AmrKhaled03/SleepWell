import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/doctor_chat_controller.dart';

class DoctorScreen extends GetWidget<DoctorChatController> {
  const DoctorScreen({super.key});

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
            AppTranslations.translate("chats",args:[]),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                GetBuilder<DoctorChatController>(
                  builder: (controller) {
                    if (controller.patients.isEmpty) {
                      return const Center(
                          child: Text('No messages from patients.'));
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: controller.patients.length,
                      itemBuilder: (context, index) {
                        var patient = controller.patients[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            tileColor: AppColors.containerColor,
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                              patient['username'],
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: patient['profile_image'] == '' ||
                                      patient['profile_image'] == null
                                  ? AssetImage("assets/images/ .jpg")
                                  : NetworkImage('${patient['profile_image']}'),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                _startChat(context, patient);
                              },
                              child: const Text('Start Chat'),
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

  void _startChat(BuildContext context, Map<String, dynamic> patient) {
    final DoctorChatController controller = Get.find<DoctorChatController>();

    controller.setCurrentPatientId(patient['id']);

    Get.toNamed(
      AppStrings.chatPageRoute,
      arguments: patient,
    );
  }
}

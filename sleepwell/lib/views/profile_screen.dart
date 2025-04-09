import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/auth_controller.dart';
import 'package:sleepwell/controllers/profile_controller.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final TextEditingController usernameController =
        TextEditingController(text: controller.user!.username);
    final TextEditingController emailController =
        TextEditingController(text: controller.user!.email);
        Get.find<AppTranslations>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title:  Text(
          AppTranslations.translate("editProfile",args:[]),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: GetBuilder<ProfileController>(
              builder: (profileController) {
                return Column(
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
                    const SizedBox(
                      height: 20,
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
                            child: (controller.user!.image != null &&
                                    controller.user!.image!.trim().isNotEmpty &&
                                    controller.user!.image != '' &&
                                    !controller.user!.image!.contains('%20'))
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
                                    icon: const Icon(Icons.camera_alt_outlined,
                                        size: 50),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:           AppTranslations.translate("hintUsername",args:[])
,
                            labelText:  AppTranslations.translate("hintUsername",args:[]),
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(),
                            hintText:  AppTranslations.translate("hintEmail",args:[]),
                            labelText: AppTranslations.translate("hintEmail",args:[]),
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          profileController.updateProfile(
                            userId: controller.user!.id,
                            role: controller.user!.role,
                            username: usernameController.text,
                            email: emailController.text,
                            image: profileController.selectedImage,
                          );
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
                    ],
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppStrings.historyScreenRoute);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.btnHistory),
                        child:  Text(
                                                    AppTranslations.translate("history",args:[]),

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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

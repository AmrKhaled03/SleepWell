import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetWidget<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final role = Get.arguments;
    if (role != null) {
      authController.setRole(role);
    }
    Get.find<AppTranslations>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title:  Text(
            AppTranslations.translate("register",args:[]),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<AuthController>(
          builder: (controller) {
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: authController.usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            
                            labelText:   AppTranslations.translate("hintUsername",args:[]),
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: authController.emailController,
                          decoration: InputDecoration(
                            labelText: AppTranslations.translate("hintEmail",args:[]),
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: authController.passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: AppTranslations.translate("hintPassword",args:[]),
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),

                          controller: authController
                              .confirmPasswordController,    
                          decoration: InputDecoration(
                            labelText: AppTranslations.translate("hintConfirmPassword",args:[]),
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          ),
                          obscureText: true,
                        ),
                
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.arrowColor),
                                padding: WidgetStatePropertyAll(
                                    EdgeInsetsDirectional.all(10))),
                            onPressed: () {
                              authController.register(
                                  authController.usernameController.text.trim(),
                                  authController.emailController.text.trim(),
                                  authController.passwordController.text.trim(),
                                  authController.confirmPasswordController.text
                                      .trim());
                            },
                            child:  Text(
                                          AppTranslations.translate("register",args:[]),

                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                                      ),
                                      icon: const Icon(Icons.login, color: Colors.white),
                                      label:  Text(
                                          AppTranslations.translate("login",args:[]),

                      style: TextStyle(fontSize: 20, color: Colors.white),
                                      ),
                                      onPressed: () {
                                    Get.offNamed(AppStrings.loginRoute);
                            
                                      },
                                    ),
                    ),
                  const SizedBox(height: 20),

                        TextButton(
                          onPressed: () {
                            Get.offNamed(AppStrings.selectRoute);
                          },
                          child: const Text('Select Role Again If You Want!',style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

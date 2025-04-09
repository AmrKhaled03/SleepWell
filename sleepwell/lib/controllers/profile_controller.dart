

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepwell/controllers/auth_controller.dart';
import 'package:sleepwell/models/api_service.dart';
import 'package:sleepwell/models/user_mdel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final ApiService apiService = ApiService();
  final AuthController authController = Get.find<AuthController>();

  bool isLoading = false;
  UserMdel? user;

  File? selectedImage;


  final ImagePicker picker = ImagePicker();

  @override
  void onInit() async {
    super.onInit();
    user = authController.user; 


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageUrl = prefs.getString('profile_image_url_${user?.id}');
    
    if (imageUrl != null) {
      user!.image = imageUrl;  
      update(); 
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);


        String? imageUrl = await uploadImageToSupabase(selectedImage!);
        if (imageUrl != null) {
          

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('profile_image_url_${user!.id}', imageUrl);


          user!.image = imageUrl;

          update(); 


      
        }
      }
    } catch (e) {
      showAwesomeDialog(
        dialogType: DialogType.error,
        title: "Error 🚨",
        desc: "Failed to pick image: $e",
      );
    }
  }

  Future<String?> uploadImageToSupabase(File image) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.png'; 
      final storageResponse = await Supabase.instance.client.storage
          .from('profile-images') 
          .upload(fileName, image);

  if (storageResponse.contains('error')) {
        debugPrint('Upload error: $storageResponse');
        return '';
      }
      final imageUrl = Supabase.instance.client.storage
          .from('profile-images')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  Future<void> updateProfile({
    required int userId,
    required String username,
    required String email,
    required String role,
    File? image,
    File? appointmentImage, 
    String? specialization, 
      String? startDate,  
    String? endDate,    
      String? description
  }) async {
    isLoading = true;
    update(); 
    try {
        showAwesomeDialog(
          dialogType: DialogType.success,
          title: "Profile Updated ✅",
          desc: "Your profile has been updated successfully! 🎉",
        );
   String? imageUrl = user?.image; 


    if (image != null) {
      imageUrl = await uploadImageToSupabase(image);
      if (imageUrl == null) {
        throw Exception("Failed to upload image to Supabase");
      }


      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_url_$userId', imageUrl);
    }

      final success = await apiService.updateProfile(
        userId: userId,
        username: username,
        email: email,
        role: role,
        imageUrl: imageUrl ,
        appointmentImage: appointmentImage,
        specialization: specialization,
           startDate: startDate,
        endDate: endDate,
        description: description
      );

      if (success) {
      
        if (user != null) {

          user!.updateProfile(
            username: username,
            email: email,
             image: imageUrl ?? user!.image, 
            specialization: specialization,
               startDate: startDate,
        endDate: endDate,
        description: description
          );


          await authController.saveUserData(user!);


          update();

          Get.back();
        } else {
          showAwesomeDialog(
            dialogType: DialogType.warning,
            title: "Error ⚠️",
            desc: "User data not found.",
          );
        }
      } else {
        showAwesomeDialog(
          dialogType: DialogType.error,
          title: "Update Failed ❌",
          desc: "Could not update your profile. Please try again!",
        );
      }
    } catch (e) {
      showAwesomeDialog(
        dialogType: DialogType.error,
        title: "An Error Occurred 😥",
        desc: "Failed to update profile: $e",
      );
    } finally {
      isLoading = false;
      update(); 
    }
  }

  void showAwesomeDialog({
    required DialogType dialogType,
    required String title,
    required String desc,
  }) {
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

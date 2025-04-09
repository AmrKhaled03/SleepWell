import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/controllers/audio_controller.dart';
import 'package:sleepwell/models/api_service.dart';
import 'package:sleepwell/models/user_mdel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  UserMdel user =
      UserMdel(id: 0, email: '', username: '', role: 'patient', image: '');
  bool isLoading = false;
  final ApiService apiService = ApiService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedRole = 'patient';
  AudioController audioController = Get.find<AudioController>();
  void setRole(String role) {
    selectedRole = role;
    update();
  }

  Future<void> register(String username, String email, String password,
      String confirmPassword) async {
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showToast('Please fill all fields', isSuccess: false);
      return;
    }

    if (password != confirmPassword) {
      _showToast('Passwords do not match', isSuccess: false);
      return;
    }

    isLoading = true;
    update();

    try {
      _showToast('Registration successful', isSuccess: true);
      final response = await apiService.registerUser(
          username, email, password, confirmPassword, selectedRole);

      if (response != null && response['success'] == true) {
        user = UserMdel(
            id: response['user_id'] ?? 0,
            email: email,
            username: username,
            role: selectedRole,
            image: response['image'] ?? '');
        emailController.clear();
        passwordController.clear();
        usernameController.clear();
        confirmPasswordController.clear();
      } else {
        String errorMessage = response?['message'] ?? 'Registration failed';

        _showToast(errorMessage, isSuccess: false);
      }
    } catch (e) {
      debugPrint("Error during registration: $e");

      _showToast("An error occurred. Please try again.", isSuccess: false);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> login() async {
    isLoading = true;
    update();

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final loggedUser = await apiService.loginWithEmail(email, password);

      if (loggedUser != null) {
        user = loggedUser;
        await saveUserData(user);
        await _loadUserData();
        if (user.role == 'doctor') {
          Get.offNamed(AppStrings.doctorHomeRoute);
        } else {
          Get.offNamed(AppStrings.homeRoute);
        }
        emailController.clear();
        passwordController.clear();
      } else {
        _showToast('Invalid email or password', isSuccess: false);
      }
    } catch (e) {
      _showToast(e.toString(), isSuccess: false);
    } finally {
      isLoading = false;
      update();
    }
  }

  void logout() async {
    user = UserMdel(id: 0, email: '', username: '', role: 'patient', image: '');
    _clearUserData();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isMusicPlaying', true);

    await audioController.resumeMusic();
    Get.offAllNamed(AppStrings.loginRoute);
  }

  void _showToast(String message, {bool isSuccess = true}) {
    AwesomeDialog(
      context: Get.overlayContext!,
      dialogType: isSuccess ? DialogType.success : DialogType.error,
      animType: AnimType.bottomSlide,
      title: isSuccess ? 'Success' : 'Error',
      desc: message,
      // autoDismiss: true,
      // dismissOnTouchOutside: true,
      // dismissOnBackKeyPress: true,
      // headerAnimationLoop: false,
      showCloseIcon: false,
      dismissOnTouchOutside: false,

      autoHide: const Duration(seconds: 3),
      customHeader: Icon(
        isSuccess ? Icons.check_circle : Icons.error,
        size: 50,
        color: isSuccess ? Colors.green : Colors.red,
      ),
    ).show();
  }

  Future<void> saveUserData(UserMdel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_username', user.username);
    await prefs.setString('user_role', user.role);
    await prefs.setString('user_description', user.description ?? '');
    await prefs.setString('user_specialization', user.specialization ?? '');
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<dynamic> results = await Future.wait([
      Future.value(prefs.getInt('user_id') ?? 0),
      Future.value(prefs.getString('user_email') ?? ''),
      Future.value(prefs.getString('user_username') ?? ''),
      Future.value(prefs.getString('user_role') ?? 'patient'),
      Future.value(prefs.getString('user_description') ?? ''),
      Future.value(prefs.getString('user_specialization') ?? ''),
    ]);

    user.id = results[0] as int;
    user.email = results[1] as String;
    user.username = results[2] as String;
    user.role = results[3] as String;
    user.description = results[4] as String;
    user.specialization = results[5] as String;
    debugPrint("User Data Loaded: ID=${user.id}, Role=${user.role}");
    update();
  }

  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_username');
    await prefs.remove('user_role');
    await prefs.remove('user_description');
    await prefs.remove('user_specialization');
  }
}

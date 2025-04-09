import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/controllers/auth_controller.dart';

class QuestionnaireController extends GetxController {
  List<dynamic> consultations = [];
  AuthController authController = Get.find<AuthController>();
  bool isSubmitted = false;


  List<String> questions = [
    '💤 How many hours do you usually sleep each night?', // Sleep Duration
    '🏃‍♂️ How would you describe your physical activity level? (1️⃣ Low, 2️⃣ Medium, 3️⃣ High)', // Physical Activity Level
    '😰 How stressed do you feel on average? (1️⃣ Low, 2️⃣ Medium, 3️⃣ High)', // Stress Level
    '🎂 What is your age?', // Age
    '🚻 What is your gender? (♂️ Male / ♀️ Female)', // Gender
    '🤔 Do you have difficulty falling asleep? (✅ Yes / ❌ No)', // difficulty_falling_asleep
    '😴 Do you snore during sleep? (✅ Yes / ❌ No)', // snore
    '🔋 Do you notice any changes in your mood or energy throughout the day? (✅ Yes / ❌ No)', // mood_energy_change
    '☕🍷 Do you consume caffeine or alcohol before bed? (✅ Yes / ❌ No)', // caffeine_alcohol_before_bed
    '🌙 How often do you wake up during the night? (1️⃣ Rarely, 2️⃣ Sometimes, 3️⃣ Often)', // Wake-up Frequency
    '⏳ How long does it usually take for you to fall asleep? (in minutes)', // Time to Fall Asleep
    '🛌 Do you wake up feeling tired? (✅ Yes / ❌ No)', // Waking Up Tired
    '📱 How much screen time do you have before bed? (in minutes)', // Screen Time Before Bed
    '😟 How anxious do you feel on average? (1️⃣ Low, 2️⃣ Medium, 3️⃣ High)', // Anxiety Level
    '😱 Do you experience nightmares or sudden awakenings during the night? (✅ Yes / ❌ No)', // Nightmares / Sudden Awakenings
    '⏰ Do you rely on an alarm to wake up in the morning? (✅ Yes / ❌ No)', // Alarm Dependency
    '🔄 How consistent is your sleep schedule? (✅ Yes / ❌ No)', // Sleep Consistency
    '👨‍💻🏋️‍♂️ What type of work do you do? (1️⃣ Sedentary, 2️⃣ Active, 3️⃣ Mixed)', // Work Type
    '🌞🌚 Do you get enough exposure to daylight during the day? (1️⃣ Yes, 2️⃣ No)', // Daylight Exposure
  ];


  Map<String, String> answers = {};
  int currentQuestionIndex = 0;
  String diagnosisResult = '';
  String advice = '';

  String insomniaPercentage = '';
  String recommendedMedication = '';
  String soothingMusic = '';
  String recommendedBooks = '';
  String suggestedExercises = '';
  String beneficialFoods = '';


  void nextQuestion(String answer) {
    if (currentQuestionIndex < questions.length) {
      answers[questions[currentQuestionIndex]] = answer;
      currentQuestionIndex++;
      update(); 
    }
  }


  void reset() {
    answers.clear();
    currentQuestionIndex = 0;
    diagnosisResult = '';
    advice = '';
    insomniaPercentage = '';
    recommendedMedication = '';
    soothingMusic = '';
    recommendedBooks = '';
    suggestedExercises = '';
    beneficialFoods = '';
    update();
    Get.offNamed(AppStrings.homeRoute);
  }


  Map<String, dynamic> get apiAnswers {
    return {
      'sleep_duration': int.tryParse(answers[questions[0]] ?? '') ?? 0,
      'physical_activity': answers[questions[1]]?.toString() ?? '',
      'stress_level': answers[questions[2]]?.toString() ?? '',
      'age': int.tryParse(answers[questions[3]] ?? '') ?? 0,
      'gender': answers[questions[4]] ?? '',
      'difficulty_falling_asleep': answers[questions[5]] ?? '',
      'snore': answers[questions[6]] ?? '',
      'mood_energy_change': answers[questions[7]] ?? '',
      'caffeine_alcohol_before_bed': answers[questions[8]] ?? '',
      'wake_up_frequency': answers[questions[9]] ?? '',
      'time_to_fall_asleep': answers[questions[10]]?.toString() ?? '',
      'waking_up_tired': answers[questions[11]] ?? '',
      'screen_time_before_bed': answers[questions[12]]?.toString() ?? '',
      'anxiety_level': answers[questions[13]]?.toString() ?? '',
      'nightmares_sudden_awakenings': answers[questions[14]] ?? '',
      'alarm_dependency': answers[questions[15]] ?? '',
      'sleep_consistency': answers[questions[16]] ?? '',
      'work_type': answers[questions[17]]?.toString() ?? '',
      'daylight_exposure': answers[questions[18]] ?? '',
    };
  }

  Future<void> getConsultationHistory() async {
    final historyApiUrl =
        "http://localhost/grad/get_history.php?user_id=${authController.user.id}";

    try {
      final response = await http.get(Uri.parse(historyApiUrl));
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          consultations = data['consultations'];
          debugPrint("User Consultations: $consultations");
          update();
        } else {
          debugPrint("Error: ${data['message']}");
        }
      } else {
        debugPrint("Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching consultations: $e");
    }
  }
  String calculateInsomniaSeverity(Map<String, dynamic> answers) {
    double severityScore = 0;

    // Sleep Duration: Poor sleep duration increases insomnia severity
    int sleepDuration = int.tryParse(answers['sleep_duration'] ?? '0') ?? 0;
    severityScore += (sleepDuration < 6) ? 3 : (sleepDuration < 8 ? 2 : 1);

    // Physical Activity Level: Less activity can worsen insomnia
    String physicalActivity = answers['physical_activity'] ?? '';
    severityScore += (physicalActivity == '1') ? 3 : (physicalActivity == '2' ? 2 : 1);

    // Stress Level: High stress increases insomnia severity
    String stressLevel = answers['stress_level'] ?? '';
    severityScore += (stressLevel == '3') ? 3 : (stressLevel == '2' ? 2 : 1);

    // Difficulty falling asleep: If true, high insomnia severity
    String difficultyFallingAsleep = answers['difficulty_falling_asleep'] ?? '';
    severityScore += (difficultyFallingAsleep == '✅ Yes') ? 3 : 0;

    // Snoring: Snoring can indicate sleep disorders
    String snore = answers['snore'] ?? '';
    severityScore += (snore == '✅ Yes') ? 2 : 0;

    // Wake-up Frequency: Frequent wake-ups add to severity
    String wakeUpFrequency = answers['wake_up_frequency'] ?? '';
    severityScore += (wakeUpFrequency == '3') ? 3 : (wakeUpFrequency == '2' ? 2 : 1);

    // Normalize severity score to a percentage
    double insomniaPercentage = (severityScore / 18) * 100;
    return '${insomniaPercentage.toStringAsFixed(2)}%';
  }
  @override
  void onInit() async {
    await getConsultationHistory();
    super.onInit();
  }
}

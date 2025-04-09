import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'dart:convert';
import 'package:sleepwell/controllers/questions_controller.dart';

class MedicalConsultantScreen extends GetWidget<QuestionnaireController> {
  const MedicalConsultantScreen({super.key});

  final String apiUrl = "https://4017-34-138-127-119.ngrok-free.app/predict";

  Future<void> submitAnswersOnce(Map<String, dynamic> answers) async {
    if (controller.isSubmitted) return;
    controller.isSubmitted = true;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(answers),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        controller.diagnosisResult =
            result['severity_level'] ?? 'No severity level found';
        controller.advice = result['advice'] ?? 'No advice available';
        controller.insomniaPercentage =
            result['insomnia_percentage']?.toString() ?? 'No data';
        controller.recommendedMedication =
            result['recommended_medication'] ?? 'No recommendation';
        controller.soothingMusic =
            result['soothing_music']?.join(", ") ?? 'No music recommended';
        controller.recommendedBooks =
            result['recommended_books']?.join(", ") ?? 'No books recommended';
        controller.suggestedExercises =
            result['suggested_exercises']?.join(", ") ??
                'No exercises recommended';
        controller.beneficialFoods =
            result['beneficial_foods']?.join(", ") ?? 'No foods recommended';

        int userId = controller.authController.user.id;
        await saveConsultationToDatabase(result, userId, answers);
      } else {
        controller.diagnosisResult = 'Error: ${response.statusCode}';
        controller.advice = 'Error retrieving advice. Please try again later.';
      }
    } catch (e) {
      controller.diagnosisResult = 'Error: $e';
      controller.advice =
          'Error retrieving advice. Please check your connection.';
    }
    controller.update();
  }

  Future<void> saveConsultationToDatabase(Map<String, dynamic> result,
      int userId, Map<String, dynamic> answers) async {
    const historyApiUrl = "http://localhost/grad/save_history.php";

    try {
      final response = await http.post(
        Uri.parse(historyApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          ...answers,
          'severity_level': result['severity_level'],
          'advice': result['advice'],
          'insomnia_percentage': result['insomnia_percentage'],
          'recommended_medication': result['recommended_medication'],
          'soothing_music': result['soothing_music']?.join(", ") ?? '',
          'recommended_books': result['recommended_books']?.join(", ") ?? '',
          'suggested_exercises':
              result['suggested_exercises']?.join(", ") ?? '',
          'beneficial_foods': result['beneficial_foods']?.join(", ") ?? '',
        }),
      );

      debugPrint("✅ Database Save Response: ${response.body}");
    } catch (e) {
      debugPrint("❌ Error saving consultation: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController answerController = TextEditingController();
    Get.find<AppTranslations>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title:  Text(
                      AppTranslations.translate("medicalConsultant",args:[]),

            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<QuestionnaireController>(
            init: QuestionnaireController(),
            builder: (controller) {
              if (controller.currentQuestionIndex <
                  controller.questions.length) {
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
                    Text(
                      controller.questions[controller.currentQuestionIndex],
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: answerController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your answer',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.arrowColor)),
                        onPressed: () {
                          if (answerController.text.isNotEmpty) {
                            controller.nextQuestion(answerController.text);
                            answerController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please provide an answer')),
                            );
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                submitAnswersOnce(controller.apiAnswers);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.diagnosisResult,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      controller.advice,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Insomnia Percentage: ${controller.insomniaPercentage}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Recommended Medication: ${controller.recommendedMedication}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Soothing Music: ${controller.soothingMusic}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Recommended Books: ${controller.recommendedBooks}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Suggested Exercises: ${controller.suggestedExercises}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Beneficial Foods: ${controller.beneficialFoods}',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 199, 28, 15))),
                          onPressed: () {
                            controller.reset();
                          },
                          child: Text(
                            "Reset",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

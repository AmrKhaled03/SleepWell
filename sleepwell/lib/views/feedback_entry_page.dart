import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/models/user_mdel.dart';
import 'package:sleepwell/models/user_feedback.dart';
import 'package:sleepwell/models/user_rating.dart';
import '../controllers/auth_controller.dart';
import '../controllers/feedback_controller.dart';

class FeedbackEntryPage extends GetWidget<FeedbackController> {
  const FeedbackEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();
    final AuthController authController = Get.find();
    UserMdel user = authController.user;

    int recommendationId = 1;
    Get.find<AppTranslations>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title:  Text(
                                            AppTranslations.translate("feedback",args:[]),

            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
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
                const SizedBox(
                  height: 20,
                ),
                 Center(
                    child: Text(
                                                  AppTranslations.translate("giveFeedback",args:[]),

                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: feedbackController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText:                                     AppTranslations.translate("feedback",args:[]),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    hintText: 'Enter your feedback here...',
                    hintStyle: const TextStyle(color: Colors.white),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      final feedback = UserFeedback(
                        id: 0,
                        userId: user.id,
                        recommendationId: recommendationId,
                        feedback: feedbackController.text,
                        createdAt: DateTime.now().toIso8601String(),
                      );
                      controller.addFeedback(feedback);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btnUpdate,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    child:  Text(
                                                      AppTranslations.translate("submit",args:[]),

                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                Center(
                  child:  Text(                                                      AppTranslations.translate("rateUs",args:[]),

                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: RatingBar.builder(
                      initialRating: controller.rating,
                      minRating: 1,
                      itemSize: 40,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        controller.rating = rating; // Set the rating value
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Rating Submit Button
                controller.isRatingSubmitted
                    ? const Center(
                        child: Text(
                          'Rating Submitted!',
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            final rating = UserRating(
                              id: 0,
                              userId: user.id,
                              recommendationId: recommendationId,
                              rating: controller.rating,
                              createdAt: DateTime.now().toIso8601String(),
                            );
                            controller.addRating(rating);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.btnUpdate,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child:  Text(
                                                                              AppTranslations.translate("submitRate",args:[]),

                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

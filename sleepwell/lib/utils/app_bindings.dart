import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/about_controller.dart';
import 'package:sleepwell/controllers/auth_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:sleepwell/controllers/chat_controller.dart';
import 'package:sleepwell/controllers/doctor_chat_controller.dart';
import 'package:sleepwell/controllers/feedback_controller.dart';
import 'package:sleepwell/controllers/food_details_controller.dart';
import 'package:sleepwell/controllers/meals_controller.dart';
import 'package:sleepwell/controllers/payment_controller.dart';
import 'package:sleepwell/controllers/profile_controller.dart';
import 'package:sleepwell/controllers/questions_controller.dart';
import 'package:sleepwell/controllers/sources_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(AppTranslations(), permanent: true);

    // Get.put(ProfileController(),permanent: true);

    // Get.lazyPut(() => SleepDataController(), fenix: true);
    Get.lazyPut(() => FeedbackController(), fenix: true);
    Get.lazyPut(() => QuestionnaireController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => DoctorChatController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => SourcesController(), fenix: true);
    Get.lazyPut(() => MealsController(), fenix: true);
    Get.lazyPut(() => FoodDetailsController(), fenix: true);
    Get.lazyPut(() => AboutController(), fenix: true);
    // Get.putAsync(() => AppTranslations().init());

  }
}

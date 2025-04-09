import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/audio_controller.dart';
import 'package:sleepwell/firebase_options.dart';
import 'package:sleepwell/utils/app_bindings.dart';
import 'package:sleepwell/views/about_screen.dart';
import 'package:sleepwell/views/book_details.dart';
import 'package:sleepwell/views/chat_screen.dart';
import 'package:sleepwell/views/details_screen.dart';
import 'package:sleepwell/views/doctor_card.dart';
import 'package:sleepwell/views/doctor_chat_screen.dart';
import 'package:sleepwell/views/doctor_home_screen.dart';
import 'package:sleepwell/views/doctor_profile_screen.dart';
import 'package:sleepwell/views/doctor_screen.dart';
import 'package:sleepwell/views/feedback_entry_page.dart';
import 'package:sleepwell/views/food_details.dart';
import 'package:sleepwell/views/healthy_food_screen.dart';
import 'package:sleepwell/views/history_screen.dart';
import 'package:sleepwell/views/home_screen.dart';
import 'package:sleepwell/views/library_screen.dart';
import 'package:sleepwell/views/login_screen.dart';
import 'package:sleepwell/views/medical_consultant_screen.dart';
import 'package:sleepwell/views/meditation_details.dart';
import 'package:sleepwell/views/meditation_screen.dart';
import 'package:sleepwell/views/member_details.dart';
import 'package:sleepwell/views/onboardind_one.dart';
import 'package:sleepwell/views/onboarding_five.dart';
import 'package:sleepwell/views/onboarding_four.dart';
import 'package:sleepwell/views/onboarding_screen_pay.dart';
import 'package:sleepwell/views/onboarding_six.dart';
import 'package:sleepwell/views/onboarding_three.dart';
import 'package:sleepwell/views/onboarding_two.dart';
import 'package:sleepwell/views/patient_chat_screen.dart';
import 'package:sleepwell/views/payment_screen.dart';
import 'package:sleepwell/views/profile_screen.dart';
import 'package:sleepwell/views/register_screen.dart';
import 'package:sleepwell/views/select_screen.dart';
import 'package:sleepwell/views/settings_screen.dart';
// import 'package:sleepwell/views/sleep_analysis_page.dart';
import 'package:sleepwell/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AudioController(), permanent: true);
  final appTranslations = AppTranslations();
  await appTranslations.init();
  await Permission.photos.request();

  await Supabase.initialize(
    url: 'https://ntxsjzwqfxcnyclbweoq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50eHNqendxZnhjbnljbGJ3ZW9xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI2MTAxNjQsImV4cCI6MjA1ODE4NjE2NH0.noe-sh4YBfWvTUhM8a9yi-bD3RnGPwNCDSPVGIOvpu0',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      'pk_test_51JlIBWH80tiAXGd0QrvOg8ybtmH5WjI0yxnHcpcy2Jw6oWBh1k8XzgNtj9opJdTRJcIoaaqv4LXRAtoVYlxu6j8U00ZsISxpat';
  Stripe.merchantIdentifier = 'merchant.com.example';
Get.putAsync(() => AppTranslations().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appTitle,
      theme: ThemeData(
        fontFamily: 'Lora',
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,

      ),
       locale: const Locale('en'), // Set initial locale based on device language
  supportedLocales: const [
    Locale('en'), // English
    Locale('ar'), // Arabic
  ],
  fallbackLocale: const Locale('en'), // Fallback locale if unsupported
  translations: AppTranslations(), // Use the translations
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate, // Add material localization for Arabic
    GlobalCupertinoLocalizations.delegate, // Add cupertino localization for Arabic
    GlobalWidgetsLocalizations.delegate, // Add widget localization
  ],
      getPages: [
        GetPage(name: AppStrings.splashRoute, page: () => const SplashScreen()),
        GetPage(name: AppStrings.homeRoute, page: () => const HomeScreen()),
        GetPage(
            name: AppStrings.registerRoute, page: () => const RegisterScreen()),
        GetPage(name: AppStrings.loginRoute, page: () => const LoginScreen()),
        GetPage(
            name: AppStrings.feedbackRoute,
            page: () => const FeedbackEntryPage()),
        GetPage(
            name: AppStrings.profileRoute, page: () => const ProfileScreen()),
        GetPage(
            name: AppStrings.medicalRoute,
            page: () => const MedicalConsultantScreen()),
        GetPage(
            name: AppStrings.doctorHomeRoute,
            page: () => const DoctorHomeScreen()),
        GetPage(
            name: AppStrings.doctorProfileRoute,
            page: () => const DoctorProfileScreen()),
        GetPage(
            name: AppStrings.chatRoute, page: () => const PatientChatScreen()),
        GetPage(
            name: AppStrings.chatPageRoute,
            page: () => const DoctorChatScreen()),
        GetPage(
            name: AppStrings.chatPageDocRoute,
            page: () => const DoctorScreen()),
        GetPage(
            name: AppStrings.chatPagePatRoute, page: () => const ChatScreen()),
        GetPage(name: AppStrings.selectRoute, page: () => const SelectScreen()),
        GetPage(
            name: AppStrings.historyScreenRoute,
            page: () => const HistoryScreen()),
        GetPage(
            name: AppStrings.detailsRoute, page: () => const DetailsScreen()),
        GetPage(
            name: AppStrings.onboardOneRoute,
            page: () => const OnboardindOne()),
        GetPage(
            name: AppStrings.onboardTwoRoute,
            page: () => const OnboardingTwo()),
        GetPage(
            name: AppStrings.onboardThreeRoute,
            page: () => const OnboardingThree()),
        GetPage(
            name: AppStrings.onboardFourRoute,
            page: () => const OnboardingFour()),
        GetPage(
            name: AppStrings.onboardFiveRoute,
            page: () => const OnboardingFive()),
        GetPage(
            name: AppStrings.onboardSixRoute,
            page: () => const OnboardingSix()),
        GetPage(
            name: AppStrings.onboardPayRoute,
            page: () => const OnboardingScreenPay()),
        GetPage(name: AppStrings.cardRoute, page: () => const DoctorCard()),
        GetPage(name: AppStrings.payRoute, page: () => const PaymentScreen()),
        GetPage(
            name: AppStrings.foodRoute, page: () => const HealthyFoodScreen()),
        GetPage(
            name: AppStrings.foodDetailsRoute, page: () => const FoodDetails()),
        GetPage(
            name: AppStrings.libraryRoute, page: () => const LibraryScreen()),
        GetPage(
            name: AppStrings.meditationRoute,
            page: () => const MeditationScreen()),
        GetPage(
            name: AppStrings.meditationDetailsRoute,
            page: () => const MeditationDetails()),
        GetPage(
            name: AppStrings.bookDetailsRoute, page: () => const BookDetails()),
        GetPage(name: AppStrings.aboutRoute, page: () => const AboutScreen()),
        GetPage(
            name: AppStrings.memberRoute, page: () => const MemberDetails()),
                    GetPage(
            name: AppStrings.settingsRoute, page: () => const SettingsScreen()),
      ],
      initialRoute: AppStrings.splashRoute,
      initialBinding: AppBindings(),
    );
  }
}

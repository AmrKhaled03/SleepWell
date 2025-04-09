import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTranslations extends Translations {
  Map<String, Map<String, String>> translations = {};

  static final Map<String, String> _localizedStrings = {};
  static const String _languageKey = 'selected_language';

  Future<AppTranslations> init() async {
    await _loadLanguages();
    await _loadSavedLanguage(); // Load the saved language
    return this;
  }

  Future<void> _loadLanguages() async {
    final String enJson = await rootBundle.loadString('assets/langs/en.json');
    final Map<String, dynamic> enMap = jsonDecode(enJson);
    final String arJson = await rootBundle.loadString('assets/langs/ar.json');
    final Map<String, dynamic> arMap = jsonDecode(arJson);

    translations = {
      'en': Map<String, String>.from(enMap),
      'ar': Map<String, String>.from(arMap),
    };

    // Initialize with default language (English) or saved language
    final savedLanguage = await _getSavedLanguage();
    _localizedStrings.addAll(translations[savedLanguage] ?? translations['en']!);
  }

  @override
  Map<String, Map<String, String>> get keys => translations;

  static String translate(String key, {List<String> args = const []}) {
    String translation = _localizedStrings[key] ?? key;
    if (args.isNotEmpty) {
      for (var i = 0; i < args.length; i++) {
        translation = translation.replaceFirst('{$i}', args[i]);
      }
    }
    return translation;
  }

  static Future<void> changeLanguage(String langCode) async {
    // Update localized strings dynamically
    final translations = Get.find<AppTranslations>().translations;
    _localizedStrings.clear();
    _localizedStrings.addAll(translations[langCode]!);

    // Save selected language
    await _saveLanguage(langCode);

    // Update locale without changing direction
    Get.updateLocale(Locale(langCode));
  }

  static Future<void> _saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, langCode);
  }

  static Future<String> _getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en'; // Default to English
  }

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await _getSavedLanguage();
    Get.updateLocale(Locale(savedLanguage));
  }
}
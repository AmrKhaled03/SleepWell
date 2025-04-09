import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/audio_controller.dart';

class SettingsScreen extends GetWidget<AudioController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.mainColor,
          title: Text(
            AppTranslations.translate("settings", args: []),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.arrowColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    AppTranslations.translate('changeLanguage', args: []),
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          backgroundColor: AppColors.mainColor,
                          title: Text(
                            AppTranslations.translate('selectLanguage',
                                args: []),
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text(
                                  AppTranslations.translate('english',
                                      args: []),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  AppTranslations.changeLanguage('en');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text(
                                  AppTranslations.translate('arabic', args: []),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  AppTranslations.changeLanguage('ar');
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<AudioController>(
                  builder: (controller) {
                    return ListTile(
                      title: Text(
                        AppTranslations.translate('toggleMusic', args: []),
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                      onTap: () {
                        controller.toggleMusic();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

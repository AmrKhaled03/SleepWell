import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/questions_controller.dart';

class HistoryScreen extends GetWidget<QuestionnaireController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AppTranslations>();
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.mainColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainColor,
            title: Text(
              AppTranslations.translate("history",args:[]),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  GetBuilder<QuestionnaireController>(
                    builder: (controller) {
                      if (controller.consultations.isEmpty) {
                        return const Center(
                            child: Text(
                          "No History Available",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ));
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        itemCount: controller.consultations.length,
                        itemBuilder: (_, index) {
                          var hist = controller.consultations[index];

                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppStrings.detailsRoute,
                                  arguments: hist);
                            },
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              tileColor: hist["insomnia_percentage"] != null &&
                                      double.tryParse(
                                              hist["insomnia_percentage"]
                                                  .toString())! <
                                          50
                                  ? AppColors.histGreen
                                  : AppColors.histRed,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                hist["created_at"] ?? "No date",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              title: Text(
                                hist["advice"] ?? "No advice available",
                                style: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 22),
                              ),
                              trailing: Text(
                                hist["insomnia_percentage"] != null
                                    ? "${hist["insomnia_percentage"]}%"
                                    : "N/A",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

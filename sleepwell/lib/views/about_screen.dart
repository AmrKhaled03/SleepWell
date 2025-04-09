import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/about_controller.dart';
import 'package:sleepwell/models/memeber_model.dart';

class AboutScreen extends GetWidget<AboutController> {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> references = [
      "assets/images/Screenshot_2025-04-06_at_1.50.17_AM-removebg-preview.png",
      "assets/images/Screenshot_2025-04-06_at_1.51.31_AM-removebg-preview.png",
      "assets/images/Screenshot_2025-04-06_at_1.52.13_AM-removebg-preview.png",
      "assets/images/Screenshot_2025-04-06_at_1.52.46_AM-removebg-preview.png"
    ];
    Get.find<AppTranslations>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Text(
          AppTranslations.translate("aboutUs",args:[]),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<AboutController>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
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
                        Center(
                            child: Image.asset(
                          "assets/images/splash.png",
                          height: 300,
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          AppStrings.appTitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: Text(
                                AppTranslations.translate("appDescription",args:[]),

                                // "Application Description ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "SleepWell is a smart mobile app that helps you track and improve your sleep quality using AI analysis.",
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: Text(AppTranslations.translate("university",args:[]),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.asset(
                                          "assets/images/Picture1.png"),
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child:
                                    Image.asset("assets/images/Picture2.png"),
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppTranslations.translate("supervisedBy",args:[]),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 20),
                              Text("👩‍🏫 Dr. Mai Mahmoud Ahmed",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22)),
                              SizedBox(height: 30),
                              Text("🧑‍💻 Teaching Assistants",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic)),
                              SizedBox(height: 20),
                              Text("👩‍💼 TA: Eng. Radwa Khaled",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22)),
                              SizedBox(height: 10),
                              Text("👩‍💼 TA: Eng. Sara Tarek",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22)),
                              SizedBox(height: 10),
                              Text("👩‍💼 TA: Eng. Wissam Khaled",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                            child: Text(
                                AppTranslations.translate("teamMembers",args:[]),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              MemeberModel member = controller.members[index];
                              return ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                title: Text(member.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(member.major,
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                leading: ClipOval(
                                  child: Hero(
                                    tag: member.id,
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey.shade200,
                                      child: member.image.isNotEmpty
                                          ? FittedBox(
                                              fit: BoxFit.contain,
                                              child:
                                                  Image.network(member.image),
                                            )
                                          : Center(child: Text("${index + 1}")),
                                    ),
                                  ),
                                ),
                                tileColor: Colors.white,
                                trailing: IconButton(
                                    onPressed: () {
                                      Get.toNamed(AppStrings.memberRoute,
                                          arguments: member);
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      size: 30,
                                    )),
                              );
                            },
                            separatorBuilder: (_, __) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: controller.members.length),
                        const SizedBox(height: 30),
                        Center(
                            child: Text(AppTranslations.translate("references",args:[]),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15),
                            itemBuilder: (_, index) {
                              dynamic reference = references[index];
                              return Container(
                                decoration: BoxDecoration(
                                    color: index == 2 || index == 3
                                        ? Colors.black
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.asset(reference),
                                ),
                              );
                            },
                            itemCount: references.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }
}

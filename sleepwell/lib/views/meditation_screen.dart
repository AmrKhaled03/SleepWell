import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/sources_controller.dart';
import 'package:sleepwell/models/excersice_model.dart';
import 'package:sleepwell/models/music_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MeditationScreen extends GetWidget<SourcesController> {
  const MeditationScreen({super.key});

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
            AppTranslations.translate("meditation",args:[]),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<SourcesController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: AppColors.arrowColor),
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
                            AppTranslations.translate("music",args:[]),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              MusicModel m = controller.music[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppStrings.meditationDetailsRoute,
                                      arguments: m);
                                },
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  tileColor: AppColors.containerColor,
                                  title: Text(
                                    m.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Text(m.singer,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  leading: Hero(
                                    tag: m.id,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(m.image),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: controller.music.length,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            AppTranslations.translate("exercises",args:[]),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 250,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  ExcersiceModel e =
                                      controller.exercises[index];
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: AppColors.containerColor,
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            e.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                e.name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: TextButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              WidgetStatePropertyAll(
                                                                  AppColors
                                                                      .startedColor)),
                                                      onPressed: () async {
                                                        final Uri url =
                                                            Uri.parse(e.link);

                                                        final encodedUrl =
                                                            Uri.encodeFull(
                                                                url.toString());

                                                        if (await canLaunchUrl(
                                                            Uri.parse(
                                                                encodedUrl))) {
                                                          await launchUrl(
                                                              Uri.parse(
                                                                  encodedUrl));
                                                        } else {
                                                          throw 'Could not launch $encodedUrl';
                                                        }
                                                      },
                                                      child: Text(
                                                        AppTranslations
                                                            .translate(
                                                                "explore",args:[]),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount: controller.exercises.length),
                          )
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

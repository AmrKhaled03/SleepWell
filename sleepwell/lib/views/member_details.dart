import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/models/memeber_model.dart';

class MemberDetails extends GetWidget {
  const MemberDetails({super.key});

  @override
  Widget build(BuildContext context) {
    MemeberModel member = Get.arguments;
    Get.find<AppTranslations>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Text(
          AppTranslations.translate("memberDetails",args:[]),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Hero(
                      tag: member.id,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                member.image,
                                fit: BoxFit.cover,
                                height: 300,
                              )))),
                  Text(member.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold)),
                  Text(member.roles,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold)),
                  Text(member.major,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

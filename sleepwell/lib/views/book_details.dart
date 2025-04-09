import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/models/books_model.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    BooksModel b = Get.arguments;
    Get.find<AppTranslations>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Text(
          AppTranslations.translate("bookDetails", args: []),
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
              Hero(
                tag: b.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    b.image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Column(
                  spacing: 20,
                  children: [
                    Text(

                      '${AppTranslations.translate("bookName", args: [])}:${b.name}',

                      // " Name : ${b.name}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(

                      '${AppTranslations.translate("bookAuthor", args: [])}:${b.author}',

                      // " Author : ${b.author}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${AppTranslations.translate("bookDescription", args: [])}:${b.description}',

                      // " Description : ${b.description}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.startedColor)),
                            onPressed: () async {
                              final Uri url = Uri.parse(b.link);

                              final encodedUrl = Uri.encodeFull(url.toString());

                              if (await canLaunchUrl(Uri.parse(encodedUrl))) {
                                await launchUrl(Uri.parse(encodedUrl));
                              } else {
                                throw 'Could not launch $encodedUrl';
                              }
                            },
                            child: Text(
                              AppTranslations.translate("explore", args: []),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

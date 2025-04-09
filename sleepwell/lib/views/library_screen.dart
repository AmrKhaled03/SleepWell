import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/constants/app_strings.dart';
import 'package:sleepwell/constants/app_translations.dart';
import 'package:sleepwell/controllers/sources_controller.dart';
import 'package:sleepwell/models/books_model.dart';

class LibraryScreen extends GetWidget<SourcesController> {
  const LibraryScreen({super.key});

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
          AppTranslations.translate("library",args:[]),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<SourcesController>(
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
                      spacing: 20,
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
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            controller.handleSearch(value);
                          },
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            labelText: 'Search',
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...controller.btns.map(
                              (btn) {
                                return Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.transparent)),
                                        onPressed: () {
                                          controller.filterBooks(btn);
                                        },
                                        child: Text(
                                          btn.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (_, index) {
                            BooksModel b = controller.books[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(AppStrings.bookDetailsRoute,
                                    arguments: b);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: Colors.white)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Hero(
                                      tag: b.id,
                                      child: Image.network(
                                        b.image,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    )),
                              ),
                            );
                          },
                          itemCount: controller.books.length,
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }
}

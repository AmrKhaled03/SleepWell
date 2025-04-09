import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/models/books_model.dart';
import 'package:sleepwell/models/excersice_model.dart';
import 'package:sleepwell/models/firebase_services.dart';
import 'package:sleepwell/models/music_model.dart';

class SourcesController extends GetxController {
  List<BooksModel> books = [];
  List<ExcersiceModel> exercises = [];
  List<MusicModel> music = [];
  List<BooksModel> allBooks = [];
  TextEditingController searchController = TextEditingController();
  FirebaseServices firebaseServices = FirebaseServices();
  bool isLoading = false;
  List<String> btns = ["all", "العربية", "english"];
  @override
  void onInit() {
    super.onInit();
    validateData();
  }

  Future<void> validateData() async {
    isLoading = true;
    update();

    try {
      allBooks = await firebaseServices.getBooks();
      books = List.from(allBooks);
      debugPrint('Books count: ${books.length}');
      exercises.assignAll(await firebaseServices.getExcercise());
      debugPrint('Exercises count: ${exercises.length}');
      music.assignAll(await firebaseServices.getMusic());
      debugPrint('Music count: ${music.length}');
      update();
    } catch (e) {
      debugPrint("Error Fetching");
    } finally {
      isLoading = false;
      update();
    }
  }

  void filterBooks(String word) {
    if (word == "all") {
      books = List.from(allBooks); 
    } else {
      books = allBooks.where((book) => book.type == word).toList();
    }
    update();
  }

  void handleSearch(String searchText) {
    if (searchText == "") {
      books = List.from(allBooks);
    } else {
      books = allBooks
          .where((book) => book.name
              .trim()
              .toLowerCase()
              .contains(searchText.trim().toLowerCase()))
          .toList();
    }
    update();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sleepwell/models/books_model.dart';
import 'package:sleepwell/models/excersice_model.dart';
import 'package:sleepwell/models/memeber_model.dart';
import 'package:sleepwell/models/music_model.dart';

class FirebaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> _read({required String collection}) async {
    return FirebaseFirestore.instance.collection(collection).get();
  }

  Future<List<MusicModel>> getMusic() async {
    try {
      QuerySnapshot response = await _read(collection: "music");
      List<QueryDocumentSnapshot<Object?>> documents = response.docs;

      List<MusicModel> music = documents.map((m) {
        MusicModel musicModel =
            MusicModel.fromJson(m.data() as Map<String, dynamic>);

        return musicModel;
      }).toList();

      return music;
    } catch (e) {
      debugPrint("Error fetching music: ${e.toString()}");
      return []; 
    }
  }

  Future<List<BooksModel>> getBooks() async {
    try {
      QuerySnapshot response = await _read(collection: "books");
      List<QueryDocumentSnapshot<Object?>> documents = response.docs;

      List<BooksModel> books = documents.map((book) {
        BooksModel booksModel =
            BooksModel.fromJson(book.data() as Map<String, dynamic>);

        return booksModel;
      }).toList();

      return books;
    } catch (e) {
      debugPrint("Error fetching books: ${e.toString()}");
      return []; 
    }
  }

Future<List<ExcersiceModel>> getExcercise() async {
  try {
    QuerySnapshot response = await _read(collection: "exercises");
    List<QueryDocumentSnapshot<Object?>> documents = response.docs;


    for (var doc in documents) {
      debugPrint('Document ID: ${doc.id}, Data: ${doc.data()}');
    }

    List<ExcersiceModel> exercises = documents.map((exercise) {
      ExcersiceModel excersiceModel =
          ExcersiceModel.fromJson(exercise.data() as Map<String, dynamic>);
      return excersiceModel;
    }).toList();

    return exercises;
  } catch (e) {
    debugPrint("Error fetching exercises: ${e.toString()}");
    return [];
  }
}



Future<List<MemeberModel>> getMembers() async {
  try {
    QuerySnapshot response = await _read(collection: "members");
    List<QueryDocumentSnapshot<Object?>> documents = response.docs;


    for (var doc in documents) {
      debugPrint('Document ID: ${doc.id}, Data: ${doc.data()}');
    }

    List<MemeberModel> members = documents.map((member) {
      MemeberModel memberModel =
          MemeberModel.fromJson(member.data() as Map<String, dynamic>);
      return memberModel;
    }).toList();

    return members;
  } catch (e) {
    debugPrint("Error fetching members: ${e.toString()}");
    return [];
  }
}
}

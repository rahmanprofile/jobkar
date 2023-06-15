import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CategoryController extends ChangeNotifier {
  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  
  Future<void> addCategory(String catOne, String catTwo) async {
    __store.collection("users").doc(__user!.uid).collection("category")
        .add({
      "cat-1" : catOne,
      "cat-2" : catTwo,
      "userId" : __user!.uid,
    }).then((value) {
      notifyListeners();
    });
  }

  Future<void> updateCategory(String catOne, String catTwo) async {
    __store.collection("users").doc(__user!.uid).collection("category").doc()
        .update({
      "cat-1" : catOne,
      "cat-2" : catTwo,
      "userId" : __user!.uid,
    }).then((value) {
      notifyListeners();
    });
  }
}
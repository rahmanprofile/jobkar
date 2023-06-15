import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobkar/controller/mysnackbar.dart';

class ProjectController extends ChangeNotifier {
  final __store = FirebaseFirestore.instance;
  final __user = FirebaseAuth.instance.currentUser;

  Future<void> addProject(context, String title, String source,String description) async {
    __store.collection("users").doc(__user!.uid).collection("projects")
        .add({
      "title" : title,
      "source" : source,
      "description" : description,
      "userId" : __user!.uid,
      "timestamp" : DateTime.now().millisecondsSinceEpoch,
    })
        .then((value) {
      notifyListeners();
      MySnackBar(context, "Project uploaded");
    });
  }

  Future<void> deleteProject(String projectId) async {
    __store.collection("users").doc(__user!.uid).collection("projects").doc(projectId)
        .delete()
        .then((value) {
      notifyListeners();
    });
  }
}
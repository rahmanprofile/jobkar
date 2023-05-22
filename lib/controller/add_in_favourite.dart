import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobkar/controller/mysnackbar.dart';

class AddInFavourite extends ChangeNotifier {
  final _auth = FirebaseAuth.instance.currentUser;
  final _store = FirebaseFirestore.instance;

  Future<void> addInternCart(context,String id, String company, String jobName,
      String newSalary, String endSalary, String type, String range, String imageUrl) async {
    await _store.collection("users").doc(_auth!.uid).collection("favourite-internships").add({
      "id": id,
      "jobName": jobName,
      "imageUrl": imageUrl,
      "company": company,
      "newSalary": newSalary,
      "endSalary": endSalary,
      "quantity": range,
      "type": type,
      "userId": _auth!.uid,
      "time": DateTime.now(),
    }).then((value) {
      MySnackBar(context, "Item added successfully");
      notifyListeners();
    });
  }


  Future<void> addJobCart(context,String id, String company, String jobName,
      String newSalary, String endSalary, String type, String range, String imageUrl) async {
    await _store.collection("users").doc(_auth!.uid).collection("favourite-jobs").add({
      "id": id,
      "jobName": jobName,
      "imageUrl": imageUrl,
      "company": company,
      "newSalary": newSalary,
      "endSalary": endSalary,
      "quantity": range,
      "type": type,
      "userId": _auth!.uid,
      "time": DateTime.now(),
    }).then((value) {
      MySnackBar(context, "Item added successfully");
      notifyListeners();
    });
  }

  Future<void> deleteFromInternship(context, String itemId) async {
    final delIntern = _store.collection("users").doc(_auth!.uid).collection("favourite-internships").doc(itemId);
    if (delIntern != null) {
      delIntern.delete();
      MySnackBar(context, "Item delete successfully");
      notifyListeners();
    }
    return;
  }

  Future<void> deleteFromJob(context, String itemId) async {
    final delJob = _store.collection("users").doc(_auth!.uid).collection("favourite-jobs").doc(itemId);
    if (delJob != null) {
      delJob.delete();
      MySnackBar(context, "Item delete successfully");
      notifyListeners();
    }
    return;
  }
}

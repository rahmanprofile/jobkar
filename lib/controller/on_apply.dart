import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobkar/controller/mysnackbar.dart';

class Apply extends ChangeNotifier {
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser;

  Future<void> onJobs(context, String name, String email, String phone,String imageUrl,String skill,String experience,
      String jobName, String company, String type, String range, String newSalary, String endSalary, String adminId) async {
    _store
        //.collection("post-jobs").doc()
        .collection("apply-jobs").add({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'imageUrl' : imageUrl,
      'skill' : skill,
      'jobName' : jobName,
      'experience' : experience,
      'company' : company,
      'type' : type,
      'quantity' : range,
      'newSalary' : newSalary,
      'endSalary' : endSalary,
      'userId' : _auth!.uid,
      'adminId' : adminId,
      'time' : DateTime.now(),
    }).then((value) =>
        MySnackBar(context, "Applied successfully"));
    notifyListeners();
  }

  Future<void> onInternship(context, String name, String email, String phone,String imageUrl,String skill,String experience,
      String jobName, String company, String type, String range, String newSalary, String endSalary,String adminId) async {
    _store
        //.collection("post-internships").doc()
        .collection("apply-internships").add({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'imageUrl' : imageUrl,
      'skill' : skill,
      'jobName' : jobName,
      'experience' : experience,
      'company' : company,
      'type' : type,
      'quantity' : range,
      'newSalary' : newSalary,
      'endSalary' : endSalary,
      'userId' : _auth!.uid,
      'adminId' : adminId,
      'time' : DateTime.now(),
    }).then((value) =>
        MySnackBar(context, "Applied successfully"));
    notifyListeners();
  }


  Future<void> onPremium(context, String name, String email, String phone,String imageUrl,String skill,String experience,
      String jobName) async {
    _store.collection("premium-apply").add({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'imageUrl' : imageUrl,
      'skill' : skill,
      'jobName' : jobName,
      'experience' : experience,
      'userId' : _auth!.uid,
      'time' : DateTime.now(),
    }).then((value) =>
        MySnackBar(context, "Applied successfully"));
    notifyListeners();
  }

  Future<void> onJobPremium(context, String name, String email, String phone,String imageUrl,String skill,String experience,
      String jobName, String company, String type, String range, String newSalary, String endSalary, String adminId) async {
    _store
        //.collection("post-jobs").doc()
        .collection("premium-jobs-apply").add({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'imageUrl' : imageUrl,
      'skill' : skill,
      'jobName' : jobName,
      'experience' : experience,
      'company' : company,
      'type' : type,
      'quantity' : range,
      'newSalary' : newSalary,
      'endSalary' : endSalary,
      'userId' : _auth!.uid,
      'adminId' : adminId,
      'time' : DateTime.now(),
    }).then((value) =>
        MySnackBar(context, "Applied successfully"));
    notifyListeners();
  }

  Future<void> onInternshipPremium(context, String name, String email, String phone,String imageUrl,String skill,String experience,
      String jobName, String company, String type, String range, String newSalary, String endSalary, String adminId) async {
    _store
        //.collection("post-internships").doc()
        .collection("premium-internships-apply").add({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'imageUrl' : imageUrl,
      'skill' : skill,
      'jobName' : jobName,
      'experience' : experience,
      'company' : company,
      'type' : type,
      'quantity' : range,
      'newSalary' : newSalary,
      'endSalary' : endSalary,
      'userId' : _auth!.uid,
      'adminId' : adminId,
      'time' : DateTime.now(),
    }).then((value) =>
        MySnackBar(context, "Applied successfully"));
    notifyListeners();
  }

}
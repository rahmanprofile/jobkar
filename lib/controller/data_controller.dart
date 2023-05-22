import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobkar/view/home.dart';
import 'package:jobkar/view/pages/details/qualification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends ChangeNotifier {
  final __store = FirebaseFirestore.instance;
  final __auth = FirebaseAuth.instance.currentUser;

  Future<void> personalData(
      context, String name, String email, String phone) async {
    try {
      final __pref = await SharedPreferences.getInstance();
      __store.collection("users").doc(__auth!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'imageUrl': '',
        'college': '',
        'course': '',
        'branch': '',
        'year': '',
        'experience': '',
        'skill': '',
        'language': '',
        'area': '',
        'city': '',
        'zipcode': '',
        'district': '',
        'state': '',
        'resume': '',
        'jid' : '',
        'github-url': '',
        'linkedin-url' : '',
        'userId': __auth!.uid,
        'time': DateTime.now(),
        'privacy-&-policy':
            "$name are completely agree with our terms and privacy policy",
        'terms-&-conditions':
            "$name are completely agree with our conditions and service security policy",
        'premium-services':
            "$name are completely agree with our premium job fundamental",
      }).then((value) {
        __pref.setString("name", name);
        __pref.setString("email", email);
        __pref.setString("phone", phone);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Qualification()),
            (route) => false);
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> qualificationData(context, String college, String course,
      String branch, String year, String experience, String skills) async {
    try {
      __store.collection("users").doc(__auth!.uid).update({
        'college': college,
        'course': course,
        'branch': branch,
        'year': year,
        'experience': experience,
        'skill': skills,
      }).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> language(context, String language) async {
    final __pref = await SharedPreferences.getInstance();
    try {
      __store.collection('users').doc(__auth!.uid).update({
        'language': language,
      }).then((value) {
        __pref.setString("language", language);
        Navigator.pop(context);
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> location(context, String city, String area, String district,
      String state, String zipcode) async {
    final __pref = await SharedPreferences.getInstance();
    try {
      __store.collection("users").doc(__auth!.uid).update({
        'area': area,
        'city': city,
        'zipcode': zipcode,
        'district': district,
        'state': state,
      }).then((value) {
        __pref.setString("area", area);
        __pref.setString("city", city);
        __pref.setString("district", district);
        __pref.setString("state", state);
        __pref.setString("zipCode", zipcode);
        Navigator.pop(context);
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> payment(String name, String email, String phone,
      String transactionId, String amount) async {
    final __pref = await SharedPreferences.getInstance();
    try {
      __store.collection('users').doc(__auth!.uid).update({
        'transaction-id': transactionId,
        'amount': amount,
        'paymentTime': DateTime.now(),
      }).then((value) {
        __pref.setString("transaction-id", transactionId);
        __pref.setString("amount", amount);
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> resume(String resumes) async {
    final __pref = await SharedPreferences.getInstance();
    try {
      __store.collection('users').doc(__auth!.uid).update({
        'resume': resumes,
      }).then((value) {
        __pref.setString("resume", resumes);
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<bool> isEmailVerified() async {
    User? user = __auth;
    return user != null && __auth!.emailVerified;
  }
}

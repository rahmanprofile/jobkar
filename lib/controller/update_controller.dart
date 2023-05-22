import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'mysnackbar.dart';

class UpdateController extends ChangeNotifier {
  final __store = FirebaseFirestore.instance;
  final __storage = FirebaseStorage.instance;
  final __user = FirebaseAuth.instance.currentUser;
  XFile? __image;

  Future<void> updateName(context, String name) async {
    __store.collection("users").doc(__user!.uid).update({
      'name': name,
    }).then((value) {
      MySnackBar(context, "Update successfully");
      notifyListeners();
    });
  }

  Future<void> updatePhone(context, String phone) async {
    __store.collection("users").doc(__user!.uid).update({
      'phone': phone,
    }).then((value) {
      MySnackBar(context, "Update successfully");
      notifyListeners();
    });
  }

  Future<void> updateEmail(context, String email) async {
    __store.collection("users").doc(__user!.uid).update({
      'email': email,
    }).then((value) {
      MySnackBar(context, "Email update successfully");
      notifyListeners();
    });
  }

  Future<void> updateJid(context, String jid) async {
    __store.collection("users").doc(__user!.uid).update({
      'jid': jid,
    }).then((value) {
      MySnackBar(context, "Update successfully");
      notifyListeners();
    });
  }

  Future<void> updateImage(context, ImageSource source) async {
    try {
      __image = await ImagePicker().pickImage(source: source, imageQuality: 50);
      final file = File(__image!.path);
      if (__image != null) {
        var snapshot = await __storage
            .ref()
            .child("profile/${__user!.uid}")
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
         __store.collection("users").doc(__user!.uid).update({
          'imageUrl': downloadUrl,
        });
        MySnackBar(context, "Profile updated");
        notifyListeners();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<void> updateCollege(context, String college) async {
    __store.collection("users").doc(__user!.uid).update({
      'college': college,
    }).then((value) {
      MySnackBar(context, "Updated successfully");
      notifyListeners();
    });
  }

  Future<void> updateCourse(context, String course) async {
    __store.collection("users").doc(__user!.uid).update({
      'course': course,
    }).then((value) {
      MySnackBar(context, "Updated successfully");
      notifyListeners();
    });
  }

  Future<void> updateBranch(context, String branch) async {
    __store.collection("users").doc(__user!.uid).update({
      'branch': branch,
    }).then((value) {
      MySnackBar(context, "Updated successfully");
      notifyListeners();
    });
  }

  Future<void> updateYear(context, String year) async {
    __store.collection("users").doc(__user!.uid).update({
      'year': year,
    }).then((value) {
      MySnackBar(context, "Updated successfully");
      notifyListeners();
    });
  }

  Future<void> updateExperience(context, String experience) async {
    __store.collection("users").doc(__user!.uid).update({
      'experience': experience,
    }).then((value) {
      MySnackBar(context, "Updated successfully");
      notifyListeners();
    });
  }

  Future<void> updateSkill(context, String skills) async {
    __store.collection("users").doc(__user!.uid).update({
      'skill': skills,
    }).then((value) {
      MySnackBar(context, "Updated successfully");
      notifyListeners();
    });
  }

  Future<void> updateZip(context, String zipcode) async {
    try {
      __store.collection("users").doc(__user!.uid).update({
        'zipcode': zipcode,
      }).then((value) {
        MySnackBar(context, "Updated successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> updateCity(context, String city) async {
    try {
      __store.collection("users").doc(__user!.uid).update({
        'city': city,
      }).then((value) {
        MySnackBar(context, "Updated successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> updateArea(context, String area) async {
    try {
      __store.collection("users").doc(__user!.uid).update({
        'area': area,
      }).then((value) {
        MySnackBar(context, "Updated successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> updateDistrict(context, String district) async {
    try {
      __store.collection("users").doc(__user!.uid).update({
        'district': district,
      }).then((value) {
        MySnackBar(context, "Updated successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }

  Future<void> updateState(context, String state) async {
    try {
      __store.collection("users").doc(__user!.uid).update({
        'state': state,
      }).then((value) {
        MySnackBar(context, "Updated successfully");
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      e.message.toString();
      notifyListeners();
    }
  }


  Future<void> updateLinkedinUrl(context, String url) async {
    __store.collection("users").doc(__user!.uid).update({
      'linkedin-url': url,
    }).then((value) {
      MySnackBar(context, "Update successfully");
      notifyListeners();
    });
  }

  Future<void> updateGithubUrl(context, String url) async {
    __store.collection("users").doc(__user!.uid).update({
      'github-url': url,
    }).then((value) {
      MySnackBar(context, "Update successfully");
      notifyListeners();
    });
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobkar/controller/mysnackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/register/code_verification.dart';
import '../view/register/phone_authentication.dart';
import '../view/pages/details/users_details.dart';

class PhoneController extends ChangeNotifier {
  final _store = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences _sharedPreferences;

  Future<void> signInWithPhoneNumber(context, String phoneNumber) async {
    try {
      verificationCompleted(AuthCredential phoneAuthCredential) async {
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        notifyListeners();
      }

      verificationFailed(FirebaseAuthException authException) async {
        MySnackBar(context, authException.message.toString());
        notifyListeners();
      }

      phoneCodeSent(String verificationId, int? token) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        notifyListeners();
        await pref.setString("verificationId", verificationId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeVerification(
              verificationId: verificationId,
              timeOutDuration: const Duration(minutes: 1),
              phoneNumber: phoneNumber,
            ),
          ),
        );
      }

      codeAutoRetrievalTimeout(String verificationId) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("verificationId", verificationId);
        notifyListeners();
      }

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(minutes: 1),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      MySnackBar(context, e.message.toString());
      notifyListeners();
    }
  }

  Future<void> verifyPhoneNumber(
      context, String verificationId, String smsCode) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(credential).then((value) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const UsersDetails()),
              (route) => false));
      notifyListeners();
      final token = await currentUser!.getIdToken();
      _sharedPreferences.setString("token", token);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      MySnackBar(context, e.message.toString());
      notifyListeners();
    }
  }

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PhoneAuth()),
        (route) => false));
    notifyListeners();
    _sharedPreferences.remove('token');
  }

  Future<void> deleteAccount(context) async {
    final user = _firebaseAuth.currentUser;
    final _db = _store.collection("users").doc(user!.uid);
    try {
      await user.delete();
      await _db.delete().then((value) {
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PhoneAuth()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      MySnackBar(context, e.message.toString());
      notifyListeners();
    }
  }
}

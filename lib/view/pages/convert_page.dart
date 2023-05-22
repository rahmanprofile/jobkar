import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobkar/view/register/phone_authentication.dart';
import '../home.dart';

class ConvertPage extends StatelessWidget {
  const ConvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return const PhoneAuth();
          }
          return const Home();
        },
      ),
    );
  }
}

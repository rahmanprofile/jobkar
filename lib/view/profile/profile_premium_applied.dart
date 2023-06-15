import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/view/components/loading_widget.dart';
import 'package:jobkar/view/pages/option/pages/components/premium_apply_user_component.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePremiumApplied extends StatefulWidget {
  const ProfilePremiumApplied({Key? key}) : super(key: key);

  @override
  State<ProfilePremiumApplied> createState() => _ProfilePremiumAppliedState();
}

class _ProfilePremiumAppliedState extends State<ProfilePremiumApplied> {
  final __user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final collection1 = FirebaseFirestore.instance.collection("premium-jobs-apply");
    final collection2 = FirebaseFirestore.instance.collection("premium-internships-apply");
    final combinedStream = Rx.combineLatest2(
      collection1.where("userId",isEqualTo: __user!.uid).snapshots().map((querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot)
          .toList()),
      collection2.where("userId",isEqualTo: __user!.uid).snapshots().map((querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot)
          .toList()),
          (collection1Docs, collection2Docs) => [collection1Docs, collection2Docs],
    );
    return Scaffold(
      body: StreamBuilder<List<List<DocumentSnapshot<Object?>>>>(
        stream: combinedStream,
        builder: (BuildContext context, AsyncSnapshot<List<List<DocumentSnapshot<Object?>>>> snapshot) {
          if (snapshot.hasData) {
            final List<List<DocumentSnapshot<Object?>>> data = snapshot.data!;
            final List<DocumentSnapshot<Object?>> collection1Docs = data[0];
            final List<DocumentSnapshot<Object?>> collection2Docs = data[1];
            return ListView.builder(
              itemCount: collection1Docs.length + collection2Docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < collection1Docs.length) {
                  return PremiumApplyUserComponent(
                    imageUrl: collection1Docs[index]['imageUrl'],
                    name: collection1Docs[index]['name'],
                    email: collection1Docs[index]['email'],
                    phone: collection1Docs[index]['phone'],
                    jobName: collection1Docs[index]['jobName'],
                    skill: collection1Docs[index]['skill'],
                    experience: collection1Docs[index]['experience'],
                  );
                } else {
                  final int newIndex = index - collection1Docs.length;
                  return PremiumApplyUserComponent(
                    imageUrl: collection2Docs[newIndex]['imageUrl'],
                    name: collection2Docs[newIndex]['name'],
                    email: collection2Docs[newIndex]['email'],
                    phone: collection2Docs[newIndex]['phone'],
                    jobName: collection2Docs[newIndex]['jobName'],
                    skill: collection2Docs[newIndex]['skill'],
                    experience: collection2Docs[newIndex]['experience'],
                  );
                }
              },
            );
          }
          return const Center(
            child: LoadingWidget(),
          );
        },
      ),
    );
  }
}

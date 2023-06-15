import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/view/pages/option/pages/components/applied_jobs_component.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../controller/on_apply.dart';

class AppliedPage extends StatefulWidget {
  const AppliedPage({Key? key}) : super(key: key);

  @override
  State<AppliedPage> createState() => _AppliedPageState();
}

class _AppliedPageState extends State<AppliedPage> {
  @override
  void initState() {
    __data();
    super.initState();
  }
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  String? skill;
  String? experience;
  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  __data() async {
    if (__user != null) {
      final _db = await __store.collection("users").doc(__user!.uid).get();
      if (_db.exists) {
        final names = _db.data()!['name'];
        final emails = _db.data()!['email'];
        final phones = _db.data()!['phone'];
        final images = _db.data()!['imageUrl'];
        final skills = _db.data()!['qualification']['skill'];
        final exp = _db.data()!['qualification']['experience'];
        setState(() {
          name = names;
          email = emails;
          phone = phones;
          imageUrl = images;
          skill = skills;
          experience = exp;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final collection1 = FirebaseFirestore.instance.collection("apply-jobs");
    final collection2 = FirebaseFirestore.instance.collection("apply-internships");
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Applied",style: GoogleFonts.roboto(fontSize: 23,fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: StreamBuilder<List<List<DocumentSnapshot<Object?>>>>(
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
                    return AppliedJobComponent(
                      imageUrl: collection1Docs[index]['imageUrl'],
                      name: collection1Docs[index]['name'],
                      email: collection1Docs[index]['email'],
                      phone: collection1Docs[index]['phone'],
                      jobName: collection1Docs[index]['jobName'],
                      skill: collection1Docs[index]['skill'],
                      experience: collection1Docs[index]['experience'],
                      onPremium:() {
                        Provider.of<Apply>(context, listen: false).onJobPremium(context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          skill.toString(),
                          experience.toString(),
                          collection1Docs[index]['jobName'],
                          collection1Docs[index]['company'],
                          collection1Docs[index]['type'],
                          collection1Docs[index]['quantity'],
                          collection1Docs[index]['newSalary'],
                          collection1Docs[index]['endSalary'],
                          collection1Docs[index]['adminId'],
                        );
                      },
                    );
                  } else {
                    final int newIndex = index - collection1Docs.length;
                    return AppliedJobComponent(
                      imageUrl: collection2Docs[newIndex]['imageUrl'],
                      name: collection2Docs[newIndex]['name'],
                      email: collection2Docs[newIndex]['email'],
                      phone: collection2Docs[newIndex]['phone'],
                      jobName: collection2Docs[newIndex]['jobName'],
                      skill: collection2Docs[newIndex]['skill'],
                      experience: collection2Docs[newIndex]['experience'],
                      onPremium:() {
                        Provider.of<Apply>(context, listen: false).onJobPremium(context,
                          name.toString(),
                          email.toString(),
                          phone.toString(),
                          imageUrl.toString(),
                          skill.toString(),
                          experience.toString(),
                          collection2Docs[newIndex]['jobName'],
                          collection2Docs[newIndex]['company'],
                          collection2Docs[newIndex]['type'],
                          collection2Docs[newIndex]['quantity'],
                          collection2Docs[newIndex]['newSalary'],
                          collection2Docs[newIndex]['endSalary'],
                          collection2Docs[newIndex]['adminId'],
                        );
                      },
                    );
                  }
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

/*StreamBuilder(
                stream: FirebaseFirestore.instance.collection("apply-jobs").where("userId",isEqualTo: __user!.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                       return AppliedJobComponent(
                           imageUrl: snapshot.data!.docs[index]['imageUrl'],
                           name: snapshot.data!.docs[index]['name'],
                           email: snapshot.data!.docs[index]['email'],
                           phone: snapshot.data!.docs[index]['phone'],
                           jobName: snapshot.data!.docs[index]['jobName'],
                           skill: snapshot.data!.docs[index]['skill'],
                           experience: snapshot.data!.docs[index]['experience'],
                           onPremium:() {
                             Provider.of<Apply>(context, listen: false).onJobPremium(context,
                               name.toString(),
                               email.toString(),
                               phone.toString(),
                               imageUrl.toString(),
                               skill.toString(),
                               experience.toString(),
                               snapshot.data!.docs[index]['jobName'],
                               snapshot.data!.docs[index]['company'],
                               snapshot.data!.docs[index]['type'],
                               snapshot.data!.docs[index]['quantity'],
                               snapshot.data!.docs[index]['newSalary'],
                               snapshot.data!.docs[index]['endSalary'],
                               snapshot.data!.docs[index]['adminId'],
                             );
                           },
                       );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),*/
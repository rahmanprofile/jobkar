import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/add_in_favourite.dart';
import 'package:jobkar/view/components/loading_widget.dart';
import 'package:jobkar/view/pages/option/pages/components/favourite_internship_component.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../controller/on_apply.dart';
import '../pages/overivew/job_overview.dart';
class ProfileFavourite extends StatefulWidget {
  const ProfileFavourite({Key? key}) : super(key: key);

  @override
  State<ProfileFavourite> createState() => _ProfileFavouriteState();
}

class _ProfileFavouriteState extends State<ProfileFavourite> {
  @override
  void initState() {
    data();
    super.initState();
  }
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  String? skill;
  String? experience;
  data() async {
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      if (userData.exists) {
        final ourName = userData.data()!['personal']['name'];
        final ourEmail = userData.data()!['personal']['email'];
        final ourPhone = userData.data()!['personal']['phone'];
        final ourImage = userData.data()!['personal']['imageUrl'];
        final ourSkill = userData.data()!['qualification']['skill'];
        final ourExp = userData.data()!['qualification']['experience'];
        setState(() {
          name = ourName;
          email = ourEmail;
          phone = ourPhone;
          imageUrl = ourImage;
          skill = ourSkill;
          experience = ourExp;
        });
      }
    }
  }
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final collection1 = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("favourite-jobs");
    final collection2 = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("favourite-internships");
    final combinedStream = Rx.combineLatest2(
      collection1.snapshots().map((querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot)
          .toList()),
      collection2.snapshots().map((querySnapshot) => querySnapshot.docs
          .map((documentSnapshot) => documentSnapshot)
          .toList()),
          (collection1Docs, collection2Docs) => [collection1Docs, collection2Docs],
    );
    return Scaffold(
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
                    return FavouriteInternshipComponent(
                      id: collection1Docs[index].id,
                      salary: collection1Docs[index]['newSalary'],
                      jobName: collection1Docs[index]['jobName'],
                      type: collection1Docs[index]['type'],
                      company: collection1Docs[index]['company'],
                      salaryEnd: collection1Docs[index]['endSalary'],
                      range: collection1Docs[index]['quantity'],
                      onDelete: () {
                        Provider.of<AddInFavourite>(context, listen: false).deleteFromJob(context,  collection1Docs[index].id);
                      },
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobOverview(
                              id: collection1Docs[index].id,
                              imageUrl: collection1Docs[index]['userId'],
                              company:collection1Docs[index]['company'],
                              type: collection1Docs[index]['type'],
                              jobName: collection1Docs[index]['jobName'],
                              endSalary: collection1Docs[index]['endSalary'],
                              newSalary: collection1Docs[index]['newSalary'],
                              address: collection1Docs[index]['address'],
                              jobFor: collection1Docs[index]['jobFor'],
                              quantity: collection1Docs[index]['quantity'],
                              requirement: collection1Docs[index]['requirement'],
                              responsibility: collection1Docs[index]['responsibility'],
                              onApply: () {
                                Provider.of<Apply>(context, listen: false).onJobs(context,
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
                              onPremium: () {
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
                            ),
                          ),
                        );
                      },
                      onApply: () {
                        Provider.of<Apply>(context, listen: false)
                            .onJobs(context,
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
                      onPremium: () {
                        Provider.of<Apply>(context, listen: false)
                            .onJobPremium(context,
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
                    return FavouriteInternshipComponent(
                      id: collection2Docs[newIndex].id,
                      salary: collection2Docs[newIndex]['newSalary'],
                      jobName: collection2Docs[newIndex]['jobName'],
                      type: collection2Docs[newIndex]['type'],
                      company: collection2Docs[newIndex]['company'],
                      salaryEnd: collection2Docs[newIndex]['endSalary'],
                      range: collection2Docs[newIndex]['quantity'],
                      onDelete: () {
                        Provider.of<AddInFavourite>(context, listen: false).deleteFromJob(context,  collection2Docs[newIndex].id);
                      },
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobOverview(
                              id: collection2Docs[newIndex].id,
                              imageUrl: collection2Docs[newIndex]['userId'],
                              company:collection2Docs[newIndex]['company'],
                              type: collection2Docs[newIndex]['type'],
                              jobName: collection2Docs[newIndex]['jobName'],
                              endSalary: collection2Docs[newIndex]['endSalary'],
                              newSalary: collection2Docs[newIndex]['newSalary'],
                              address: collection2Docs[newIndex]['address'],
                              jobFor: collection2Docs[newIndex]['jobFor'],
                              quantity: collection2Docs[newIndex]['quantity'],
                              requirement: collection2Docs[newIndex]['requirement'],
                              responsibility: collection2Docs[newIndex]['responsibility'],
                              onApply: () {
                                Provider.of<Apply>(context, listen: false).onJobs(context,
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
                              onPremium: () {
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
                            ),
                          ),
                        );
                      },
                      onApply: () {
                        Provider.of<Apply>(context, listen: false)
                            .onJobs(context,
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
                      onPremium: () {
                        Provider.of<Apply>(context, listen: false)
                            .onJobPremium(context,
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
              child: LoadingWidget(),
            );
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../controller/add_in_favourite.dart';
import '../../controller/on_apply.dart';
import '../components/card_internship.dart';
import '../components/card_jobs.dart';
import 'overivew/job_overview.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  final searchController = TextEditingController();
  var searchItem = '';

  @override
  Widget build(BuildContext context) {
    final collection1 = FirebaseFirestore.instance.collection("post-jobs");
    final collection2 = FirebaseFirestore.instance.collection("post-internships");
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
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CupertinoSearchTextField(
            controller: searchController,
            backgroundColor: Colors.grey[200],
            onChanged: (value) {
              setState(() {
                searchItem = value;
              },
              );
            },
          ),
        ),
      ),
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
                  String textData = collection1Docs[index]['jobName'];
                  if (searchController.text.isEmpty) {
                    return CardJob(
                      id: collection1Docs[index].id,
                      salary: collection1Docs[index]['newSalary'],
                      jobName: collection1Docs[index]['jobName'],
                      type: collection1Docs[index]['type'],
                      company: collection1Docs[index]['company'],
                      salaryEnd: collection1Docs[index]['endSalary'],
                      range: collection1Docs[index]['quantity'],
                      orgLogo: collection1Docs[index]['logoUrl'],
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobOverview(
                              id: collection1Docs[index].id,
                              imageUrl: collection1Docs[index]['logoUrl'],
                              company: collection1Docs[index]['company'],
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
                                  collection1Docs[index]['oldSalary'],
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
                                  collection1Docs[index]['oldSalary'],
                                  collection1Docs[index]['adminId'],
                                );
                              },
                            ),
                          ),
                        );
                      }, // work perfectly done
                      onFav: () {
                        Provider.of<AddInFavourite>(context, listen: false).addJobCart(
                          context,
                          collection1Docs[index].id,
                          collection1Docs[index]['company'],
                          collection1Docs[index]['jobName'],
                          collection1Docs[index]['newSalary'],
                          collection1Docs[index]['endSalary'],
                          collection1Docs[index]['type'],
                          collection1Docs[index]['quantity'],
                          collection1Docs[index]['newSalary'],
                        );
                      },  // work perfectly done
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
                      }, // work perfectly done
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
                      }, // work perfectly done
                    );
                  } else if (textData.toUpperCase().contains(searchController.text.toString()) ||
                      textData.toLowerCase().contains(searchController.text.toLowerCase()))
                  {
                    return CardJob(
                      id: collection1Docs[index].id,
                      salary: collection1Docs[index]['newSalary'],
                      jobName: collection1Docs[index]['jobName'],
                      type: collection1Docs[index]['type'],
                      company: collection1Docs[index]['company'],
                      salaryEnd: collection1Docs[index]['endSalary'],
                      range: collection1Docs[index]['quantity'],
                      orgLogo: collection1Docs[index]['logoUrl'],
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobOverview(
                              id: collection1Docs[index].id,
                              imageUrl: collection1Docs[index]['logoUrl'],
                              company: collection1Docs[index]['company'],
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
                                  collection1Docs[index]['oldSalary'],
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
                                  collection1Docs[index]['oldSalary'],
                                  collection1Docs[index]['adminId'],
                                );
                              },
                            ),
                          ),
                        );
                      }, // work perfectly done
                      onFav: () {
                        Provider.of<AddInFavourite>(context, listen: false).addJobCart(
                          context,
                          collection1Docs[index].id,
                          collection1Docs[index]['company'],
                          collection1Docs[index]['jobName'],
                          collection1Docs[index]['newSalary'],
                          collection1Docs[index]['endSalary'],
                          collection1Docs[index]['type'],
                          collection1Docs[index]['quantity'],
                          collection1Docs[index]['newSalary'],
                        );
                      },  // work perfectly done
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
                      }, // work perfectly done
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
                      }, // work perfectly done
                    );
                  }

                } else {
                  final int newIndex = index - collection1Docs.length;
                  String text2Data = collection2Docs[newIndex]['jobName'];
                  if (searchController.text.isEmpty) {
                    return CardInternship(
                      id: collection2Docs[newIndex].id,
                      salary: collection2Docs[newIndex]['newSalary'],
                      jobName: collection2Docs[newIndex]['jobName'],
                      type: collection2Docs[newIndex]['type'],
                      company: collection2Docs[newIndex]['company'],
                      salaryEnd: collection2Docs[newIndex]['endSalary'],
                      range: collection2Docs[newIndex]['quantity'],
                      orgLogo: collection2Docs[newIndex]['logoUrl'],
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobOverview(
                              id: collection2Docs[newIndex].id,
                              imageUrl: collection2Docs[newIndex]['logoUrl'],
                              company: collection2Docs[newIndex]['company'],
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
                                Provider.of<Apply>(context, listen: false).onInternship(context,
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
                                  collection2Docs[newIndex]['oldSalary'],
                                  collection2Docs[newIndex]['adminId'],
                                );
                              },
                              onPremium: () {
                                Provider.of<Apply>(context, listen: false).onInternshipPremium(context,
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
                                  collection2Docs[newIndex]['oldSalary'],
                                  collection2Docs[newIndex]['adminId'],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      onFav: () {
                        Provider.of<AddInFavourite>(context, listen: false).addInternCart(
                          context,
                          collection2Docs[newIndex].id,
                          collection2Docs[newIndex]['company'],
                          collection2Docs[newIndex]['jobName'],
                          collection2Docs[newIndex]['newSalary'],
                          collection2Docs[newIndex]['endSalary'],
                          collection2Docs[newIndex]['type'],
                          collection2Docs[newIndex]['quantity'],
                          collection2Docs[newIndex]['newSalary'],
                        );
                      },
                      onApply: () {
                        Provider.of<Apply>(context, listen: false).onInternship(context,
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
                            collection2Docs[newIndex]['adminId']
                        );
                      },
                      onPremium: () {
                        Provider.of<Apply>(context, listen: false).onInternshipPremium(context,
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
                            collection2Docs[newIndex]['adminId']
                        );
                      },
                    );
                  } else if (text2Data.toLowerCase().contains(searchController.text.toLowerCase()) ||
                      text2Data.toUpperCase().contains(searchController.text.toUpperCase()))
                  {
                    return CardInternship(
                      id: collection2Docs[newIndex].id,
                      salary: collection2Docs[newIndex]['newSalary'],
                      jobName: collection2Docs[newIndex]['jobName'],
                      type: collection2Docs[newIndex]['type'],
                      company: collection2Docs[newIndex]['company'],
                      salaryEnd: collection2Docs[newIndex]['endSalary'],
                      range: collection2Docs[newIndex]['quantity'],
                      orgLogo: collection2Docs[newIndex]['logoUrl'],
                      onView: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobOverview(
                              id: collection2Docs[newIndex].id,
                              imageUrl: collection2Docs[newIndex]['logoUrl'],
                              company: collection2Docs[newIndex]['company'],
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
                                Provider.of<Apply>(context, listen: false).onInternship(context,
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
                                  collection2Docs[newIndex]['oldSalary'],
                                  collection2Docs[newIndex]['adminId'],
                                );
                              },
                              onPremium: () {
                                Provider.of<Apply>(context, listen: false).onInternshipPremium(context,
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
                                  collection2Docs[newIndex]['oldSalary'],
                                  collection2Docs[newIndex]['adminId'],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      onFav: () {
                        Provider.of<AddInFavourite>(context, listen: false).addInternCart(
                          context,
                          collection2Docs[newIndex].id,
                          collection2Docs[newIndex]['company'],
                          collection2Docs[newIndex]['jobName'],
                          collection2Docs[newIndex]['newSalary'],
                          collection2Docs[newIndex]['endSalary'],
                          collection2Docs[newIndex]['type'],
                          collection2Docs[newIndex]['quantity'],
                          collection2Docs[newIndex]['newSalary'],
                        );
                      },
                      onApply: () {
                        Provider.of<Apply>(context, listen: false).onInternship(context,
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
                            collection2Docs[newIndex]['adminId']
                        );
                      },
                      onPremium: () {
                        Provider.of<Apply>(context, listen: false).onInternshipPremium(context,
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
                            collection2Docs[newIndex]['adminId']
                        );
                      },
                    );
                  }

                }
                return Container();
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

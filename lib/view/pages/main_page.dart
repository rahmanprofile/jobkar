import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/add_in_favourite.dart';
import 'package:jobkar/controller/on_apply.dart';
import 'package:jobkar/controller/phone_controller.dart';
import 'package:jobkar/view/components/card_internship.dart';
import 'package:jobkar/view/components/card_jobs.dart';
import 'package:jobkar/view/pages/option/pages/applied_page.dart';
import 'package:jobkar/view/pages/option/pages/favourite_job_pages.dart';
import 'package:jobkar/view/pages/option/pages/premium_page.dart';
import 'package:jobkar/view/pages/option/technical_support.dart';
import 'package:jobkar/view/pages/overivew/company_overview.dart';
import 'package:jobkar/view/pages/overivew/job_overview.dart';
import 'package:jobkar/view/placement/placement.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        final skills = _db.data()!['skill'];
        final exp = _db.data()!['experience'];
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
  List<String> itemList = [
    "assets/com/google.png",
    "assets/com/amazon.png",
    "assets/com/microsoft.png",
    "assets/com/netflix.png",
    "assets/com/flipkart.png",
    "assets/com/hp.png",
    "assets/com/tcs.png",
    "assets/com/genpact.png",
    "assets/com/WIT_BIG.png",
    "assets/com/dell.png",
    "assets/com/hcl.png",
    "assets/com/paytm.png",
  ];
  final searchController = TextEditingController();
   String jobName = '';
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
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AppliedPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Applied",
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FavouriteJobList()));
                                      },
                                      child: Text(
                                        "Favourite",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PremiumPage()));
                                      },
                                      child: Text(
                                        "Premium",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PlacementPlace()));
                                      },
                                      child: Text(
                                        "Placement",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TechnicalSupport()));
                                      },
                                      child: Text(
                                        "Help",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Alert?",
                                                style: GoogleFonts.roboto(),
                                              ),
                                              content: Text(
                                                "Are you sure want to logout.",
                                                style: GoogleFonts.roboto(),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "No",
                                                      style: GoogleFonts.roboto(
                                                          color: Colors.black),
                                                    )),
                                                TextButton(
                                                  onPressed: () {
                                                    Provider.of<PhoneController>(
                                                            context,
                                                            listen: false)
                                                        .signOut(context);
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Logout",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.roboto(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Center(
                          child: Icon(LineAwesomeIcons.stream, size: 20),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageUrl.toString(),
                          placeholder: (context, url) => const Icon(CupertinoIcons.person_fill,color: Colors.black54),
                          errorWidget: (context, url, error) => const Icon(CupertinoIcons.person_fill),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  "Grab Your \nOpportunity in MNC'S?",
                  style: GoogleFonts.roboto(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    backgroundColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        jobName = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 5.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(itemList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CompanyOverview(),
                              ),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(itemList[index]),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  "Apply",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 0),
                StreamBuilder<List<List<DocumentSnapshot<Object?>>>>(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

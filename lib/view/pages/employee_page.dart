import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/add_in_favourite.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/controller/on_apply.dart';
import 'package:jobkar/view/components/card_jobs.dart';
import 'package:jobkar/view/components/loading_widget.dart';
import 'package:jobkar/view/pages/option/pages/applied_page.dart';
import 'package:jobkar/view/pages/search_page.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../components/card_internship.dart';
import '../placement/placement.dart';
import 'option/pages/favourite_job_pages.dart';
import 'internship_page.dart';
import 'overivew/job_overview.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
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
  final user = FirebaseAuth.instance.currentUser;
  __data() async {
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      if (userData.exists) {
        final ourName = userData.data()!['name'];
        final ourEmail = userData.data()!['email'];
        final ourPhone = userData.data()!['phone'];
        final ourImage = userData.data()!['imageUrl'];
        final ourSkill = userData.data()!['skill'];
        final ourExp = userData.data()!['experience'];
        setState(() {
          name = ourName;
          email = ourEmail;
          phone = ourPhone;
          imageUrl = ourImage;
          experience = ourExp;
          skill = ourSkill;
        });
      }
    }
  }

  final searchController = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Seekers",style: GoogleFonts.roboto(color: Colors.black,fontSize: 22),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            icon: const Icon(CupertinoIcons.search, size: 20,color: Colors.black,),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _carouselCard(),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Expanded(
                    child: _shareCard(
                      "Placement",
                      "assets/bng/job.png",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlacementPlace(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 3.0),
                  Expanded(
                    child: _shareCard("Internship", "assets/bng/internship.png",
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InternshipPage(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 3.0),
                  Expanded(
                    child: _shareCard("Favourite", "assets/bng/fav.png", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavouriteJobList()));
                    }),
                  ),
                  const SizedBox(width: 3.0),
                  Expanded(
                    child: _shareCard("Applied", "assets/bng/mailbox.png", () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => const AppliedPage()));
                    },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Improve Your \nJob Prospects with \nPremium Jobs",
                            style: GoogleFonts.sansita(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                          Text(
                            "Join over 1 million+ satisfied users today!",
                            style:
                                GoogleFonts.roboto(color: Colors.orange[700],fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset("assets/img/task.png",
                              height: 50, width: 50, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
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
                        } else {
                          final int newIndex = index - collection1Docs.length;
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
                      },
                    );
                  }
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: LoadingWidget(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //.....................................caresCad.........................
  Widget _carouselCard() {
    List<String> imageList = [
      "assets/bng/1.png",
      "assets/bng/2.png",
      "assets/bng/3.png",
    ];
    return CarouselSlider.builder(
      itemCount: imageList.length,
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,
        clipBehavior: Clip.antiAlias,
        height: MediaQuery.of(context).size.height * 0.160,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: whiteColor,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You can \nNever find good \nJobs?",
                      style: GoogleFonts.sansita(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Until you can not find good place!",
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFD81B60),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: softColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imageList[index],
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //................................................Share Card............
  Widget _shareCard(String title, String imageUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: whiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imageUrl, fit: BoxFit.cover, height: 30, width: 30),
            const SizedBox(height: 3.0),
            Text(title, style: styleBlack10),
          ],
        ),
      ),
    );
  }

  //,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  Widget sideText() {
    return Row(
      children: [
        Text(
          "POPULAR",
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFC2185B),
          ),
        ),
        const Spacer(),
        //Text("See All",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w500,color:  Colors.black,),),
      ],
    );
  }
}

/*Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.white,
                  ),
                ),
                _carouselCard(),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Expanded(
                      child: _shareCard(
                        "Placement",
                        "assets/bng/job.png",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlacementPlace(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: _shareCard(
                          "Internship", "assets/bng/internship.png", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InternshipPage(),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: _shareCard("Favourite", "assets/bng/fav.png", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FavouriteJobList()));
                      }),
                    ),
                    const SizedBox(width: 5.0),
                    Expanded(
                      child: _shareCard("Profile", "assets/bng/pro.png", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()));
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlacementPlace(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "More than \n10+ lacs people using \nPremium Jobs",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                              Text(
                                "They Are Happy Customer",
                                style:
                                    GoogleFonts.jost(color: Colors.orange[700]),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: softColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/img/hot_coffee.png",
                                  height: 50, width: 50, fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      // .collection("recruiters")
                      // .doc()
                      .collection("jobs")
                      .where('uid', isNotEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("loading . . ."),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 12 ?? snapshot.data!.docs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CardJob(
                            id: '74bc5745b43n6bv5976',
                            salary: "45,000",
                            jobName: "Sales & Marketing",
                            type: "Fresher",
                            company: "Flipkart",
                            salaryEnd: "55,000",
                            range: "20",
                            onFav: (){},
                            onView: (){},
                            onApply: (){},
                            onPremium: (){},
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),*/

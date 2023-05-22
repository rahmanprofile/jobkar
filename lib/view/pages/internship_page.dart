import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/add_in_favourite.dart';
import 'package:jobkar/controller/on_apply.dart';
import 'package:jobkar/view/pages/option/pages/applied_page.dart';
import 'package:jobkar/view/pages/search_page.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';
import '../components/card_internship.dart';
import '../placement/placement.dart';
import 'option/pages/favourite_internship_pages.dart';
import 'overivew/job_overview.dart';

class InternshipPage extends StatefulWidget {
  const InternshipPage({Key? key}) : super(key: key);

  @override
  State<InternshipPage> createState() => _InternshipPageState();
}

class _InternshipPageState extends State<InternshipPage> {
  @override
  void initState() {
    __data();
    super.initState();
  }
  final _user = FirebaseAuth.instance.currentUser;
  String? email;
  String? phone;
  String? name;
  String? skill;
  String? experience;
  String? imageUrl;
  __data() async {
    if (_user != null) {
      final userData = await FirebaseFirestore.instance
          .collection("users")
          .doc(_user?.uid)
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme:const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Internship",style: GoogleFonts.roboto(color: Colors.black,fontSize: 22),),
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
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
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
                              builder: (context) =>
                                  const FavouriteInternshipList()));
                    }),
                  ),
                  const SizedBox(width: 3.0),
                  Expanded(
                    child: _shareCard("Applied", "assets/bng/mailbox.png", () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => const AppliedPage()));
                    }),
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
                  padding: const EdgeInsets.all(5.0),
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("post-internships").snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardInternship(
                          id: snapshot.data!.docs[index].id,
                          salary: snapshot.data!.docs[index]['newSalary'],
                          jobName: snapshot.data!.docs[index]['jobName'],
                          type: snapshot.data!.docs[index]['type'],
                          company: snapshot.data!.docs[index]['company'],
                          salaryEnd: snapshot.data!.docs[index]['endSalary'],
                          range: snapshot.data!.docs[index]['quantity'],
                          orgLogo: snapshot.data!.docs[index]['logoUrl'],
                          onFav: () {
                            Provider.of<AddInFavourite>(context, listen: false).addInternCart(context,
                              snapshot.data!.docs[index].id,
                              snapshot.data!.docs[index]['company'],
                              snapshot.data!.docs[index]['jobName'],
                              snapshot.data!.docs[index]['newSalary'],
                              snapshot.data!.docs[index]['endSalary'],
                              snapshot.data!.docs[index]['type'],
                              snapshot.data!.docs[index]['quantity'],
                              snapshot.data!.docs[index]['logoUrl'],
                            );
                          },
                          onView: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JobOverview(
                                  id: snapshot.data!.docs[index].id,
                                  imageUrl: snapshot.data!.docs[index]['logoUrl'],
                                  company: snapshot.data!.docs[index]['company'],
                                  type: snapshot.data!.docs[index]['type'],
                                  jobName: snapshot.data!.docs[index]['jobName'],
                                  endSalary: snapshot.data!.docs[index]['endSalary'],
                                  newSalary: snapshot.data!.docs[index]['newSalary'],
                                  address: snapshot.data!.docs[index]['address'],
                                  jobFor: snapshot.data!.docs[index]['jobFor'],
                                  quantity: snapshot.data!.docs[index]['quantity'],
                                  requirement: snapshot.data!.docs[index]['requirement'],
                                  responsibility: snapshot.data!.docs[index]['responsibility'],
                                  onApply: () {
                                    Provider.of<Apply>(context, listen: false).onJobs(context,
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
                                  onPremium: () {
                                    Provider.of<Apply>(context, listen: false).onInternshipPremium(context,
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
                                ),
                              ),
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
                              snapshot.data!.docs[index]['jobName'],
                              snapshot.data!.docs[index]['company'],
                              snapshot.data!.docs[index]['type'],
                              snapshot.data!.docs[index]['quantity'],
                              snapshot.data!.docs[index]['newSalary'],
                              snapshot.data!.docs[index]['endSalary'],
                              snapshot.data!.docs[index]['adminId'],
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
      //"assets/bng/banner4.jpg",
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
          //padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 8.0),
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
                          color: Colors.orange[600]),
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
}

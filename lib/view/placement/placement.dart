import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/on_apply.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';

class PlacementPlace extends StatefulWidget {
  const PlacementPlace({Key? key}) : super(key: key);

  @override
  State<PlacementPlace> createState() => _PlacementPlaceState();
}

class _PlacementPlaceState extends State<PlacementPlace> {
  @override
  void initState() {
    super.initState();
    __data();
  }
  final __user = FirebaseAuth.instance.currentUser;
  final __store = FirebaseFirestore.instance;
  String? names;
  String? emails;
  String? phones;
  String? colleges;
  String? courses;
  String? branch;
  String? years;
  String? skills;
  String? experiences;
  String? imageUrl;
  __data() async {
    if (__user != null) {
      final data = await __store.collection("users").doc(__user!.uid).get();
      if (data.exists) {
        final name = data.data()!['name'];
        final image = data.data()!['imageUrl'];
        final email = data.data()!['email'];
        final phone = data.data()!['phone'];
        final college = data.data()!['college'];
        final course = data.data()!['course'];
        final year = data.data()!['year'];
        final skill = data.data()!['skill'];
        final branches = data.data()!['branch'];
        final experience = data.data()!['experience'];
        setState(() {
          names = name;
          emails = email;
          imageUrl = image;
          phones = phone;
          colleges = college;
          courses = course;
          years = year;
          skills = skill;
          experiences = experience;
          branch = branches;
        });
      }
    }
  }
  final searchController = TextEditingController();
  List<String> listItems = [
    "Artificial Intelligence",
    "Machine Learning",
    "Data Science",
    "Java Core",
    "Javascript",
    "Python",
    "Digital Marketing",
    "Real-State",
    "Software Testing",
    "Flutter Development",
    "React JS",
    "Spring & boot",
    "Angular",
    "Sales & Marketing",
    "Autocad",
    "System Engineer",
    "Java fullstack",
    "Python fullstack",
    "PHP Development",
    ".Net Development",
    "C/C++",
    "Project Management",
    "Ethical Hacking",
    "Project Manager",
    "Human Resource",
    "System Administrator",
    "Computer Engineer",
    "Salesforce Administrator",
    "Database Administrator",
  ];
  List<String> rangeList = [
    "403.7L",
    "151.7L",
    "129.4L",
    "91.1k",
    "34.2k",
    "22.9k",
    "77.1k",
    "56.1k",
    "50.1k",
    "42.9k",
    "100.1L",
    "12.3k",
    "43.5k",
    "12.7k",
    "201.1k",
    "118.1L",
    "158.0L",
    "220.4k",
    "120.5k",
    "22.1k",
    "15.1k",
    "34.8k",
    "87.2k",
    "98.2k",
    "97.1k",
    "11.0k",
    "54.2k",
    "65.2k",
    "1.1k",
    "45.2k"
  ];
  List<String> peopleList = [
    "56.7K+",
    "12.7+",
    "31.0+",
    "34.1+",
    "22.2+",
    "2.9k+",
    "410.1+",
    "56.1+",
    "50.1+",
    "42.9k",
    "100.1+",
    "12.3+",
    "23.5+",
    "1.7k+",
    "21.1k+",
    "118.1+",
    "38.0+",
    "120.4+",
    "110.5+",
    "221.1+",
    "105.1+",
    "322.8+",
    "187.2+",
    "918.2+",
    "37.1+",
    "110.0+",
    "554.2+",
    "115.2+",
    "10.1k+",
    "477.2+"
  ];
  var searchValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Premium",
          style: GoogleFonts.roboto(color: Colors.black, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 45,
              width: double.infinity,
              child: CupertinoSearchTextField(
                controller: searchController,
                backgroundColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 5.0),
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
                          style: GoogleFonts.roboto(
                              color: Colors.orange[700], fontSize: 13),
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
            const SizedBox(height: 5.0),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                String searchData = listItems[index].toString();
                if (searchController.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const StudyForm()));
                        Provider.of<Apply>(context, listen: false).onPremium(
                          context,
                          names.toString(),
                          emails.toString(),
                          phones.toString(),
                          imageUrl.toString(),
                          listItems[index],
                          experiences.toString(),
                          listItems[index],
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset("assets/img/group.png"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listItems[index],
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black12,
                                      ),
                                      child: const Center(
                                        child: Icon(CupertinoIcons.person_fill,
                                            size: 10),
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red[400],
                                        ),
                                        child: const Center(
                                          child: Icon(CupertinoIcons.person_fill,
                                              size: 10),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange[400],
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            LineAwesomeIcons.user,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 35,
                                      top: 5,
                                      child: Text(
                                        peopleList[index],
                                        style: GoogleFonts.roboto(
                                            fontSize: 10, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rangeList[index],
                                  style: GoogleFonts.roboto(
                                      fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "APPLIED",
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (searchData.toUpperCase().contains(searchController.text.toUpperCase()) ||
                    searchData.toLowerCase().contains(searchController.text.toString())) {
                  {
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const StudyForm()));
                          Provider.of<Apply>(context, listen: false).onPremium(
                            context,
                            names.toString(),
                            emails.toString(),
                            phones.toString(),
                            imageUrl.toString(),
                            listItems[index],
                            experiences.toString(),
                            listItems[index],
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: Colors.white,
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/img/group.png"))),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listItems[index],
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black12,
                                        ),
                                        child: const Center(
                                          child: Icon(CupertinoIcons.person_fill,
                                              size: 10),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red[400],
                                          ),
                                          child: const Center(
                                            child: Icon(CupertinoIcons.person_fill,
                                                size: 10),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.orange[400],
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              LineAwesomeIcons.user,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 15,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 35,
                                        top: 5,
                                        child: Text(
                                          peopleList[index],
                                          style: GoogleFonts.roboto(
                                              fontSize: 10, color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    rangeList[index],
                                    style: GoogleFonts.roboto(
                                        fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "APPLIED",
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

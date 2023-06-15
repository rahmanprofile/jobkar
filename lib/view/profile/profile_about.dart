import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../controller/data_controller.dart';
import '../pages/details/update_location.dart';
import '../pages/details/update_qualification.dart';

class ProfileAbout extends StatefulWidget {
  const ProfileAbout({Key? key}) : super(key: key);

  @override
  State<ProfileAbout> createState() => _ProfileAboutState();
}

class _ProfileAboutState extends State<ProfileAbout> {
  @override
  void initState() {
    super.initState();
    __data();
  }
  String img = "";
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
  String? jid;
  String? area;
  String? city;
  String? district;
  String? state;
  String? zipCode;
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
        final myJid = data.data()!['jid'];
        final myArea = data.data()!['area'];
        final myDist = data.data()!['district'];
        final myState = data.data()!['district'];
        final myCode = data.data()!['zipcode'];
        final myCity = data.data()!['city'];
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
          jid = myJid;
          area = myArea;
          district = myDist;
          state = myState;
          zipCode = myCode;
          city = myCity;
        });
      }
    }
  }
  bool _isEmailVerified = false;
  void checkEmailVerified() async {
    bool isVerified = await DataController().isEmailVerified();
    setState(() {
      _isEmailVerified = isVerified;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children:[
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  "Qualification",
                  style: GoogleFonts.quicksand(
                      color: Colors.black54,
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateQualification()));
                  },
                  child: const Icon(LineAwesomeIcons.edit, size: 18),
                )
              ],
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                //border: Border.all(color: Colors.black12)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    colleges.toString(),
                    style: GoogleFonts.ptSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  Text(
                    "$courses & $branch",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  Text(
                    "Year - $years",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Experience",
                  style: GoogleFonts.quicksand(
                      color: Colors.black54,
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateQualification()));
                  },
                  child: const Icon(LineAwesomeIcons.edit, size: 18),
                )
              ],
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                //border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Skill : $skills \nExperience : $experiences",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Category",
                  style: GoogleFonts.quicksand(
                      color: Colors.black54,
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateQualification()));
                  },
                  child: const Icon(LineAwesomeIcons.edit, size: 18),
                )
              ],
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                //border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cat-1 : Software Development \nCat-2 : Web Development",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Location",
                  style: GoogleFonts.quicksand(
                    color: Colors.black54,
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateLocation()));
                  },
                  child: const Icon(LineAwesomeIcons.edit, size: 18),
                )
              ],
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                //border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Area : $area \nCity : $city \nState : $state - $zipCode",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

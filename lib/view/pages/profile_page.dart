import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/controller/data_controller.dart';
import 'package:jobkar/controller/phone_controller.dart';
import 'package:jobkar/view/pages/details/update_location.dart';
import 'package:jobkar/view/pages/details/update_qualification.dart';
import 'package:jobkar/view/pages/details/update_user_address.dart';
import 'package:jobkar/view/pages/details/update_user_details.dart';
import 'package:jobkar/view/pages/option/technical_support.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import '../../controller/update_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    img = "assets/img/bg.jpg";
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: GoogleFonts.roboto(color: Colors.black, fontSize: 22),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdateUserDetails()),
                            );
                          },
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: softColor,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(color: Colors.black12)),
                            child: const Center(
                              child: Icon(LineIcons.user, size: 17),
                            ),
                          ),
                          title: Text(
                            "Personal Details",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            "Update your personal details",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward,
                              size: 17),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdateQualification()),
                            );
                          },
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: softColor,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(color: Colors.black12)),
                            child: const Center(
                              child: Icon(LineIcons.graduationCap, size: 17),
                            ),
                          ),
                          title: Text(
                            "Education",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            "Update your education details",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward,
                              size: 17),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateUserAddress()));
                          },
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: softColor,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(color: Colors.black12)),
                            child: const Center(
                              child: Icon(LineIcons.campground, size: 17),
                            ),
                          ),
                          title: Text(
                            "Address",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            "Update your current location",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward,
                              size: 17),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TechnicalSupport()));
                          },
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: softColor,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(color: Colors.black12)),
                            child: const Center(
                              child: Icon(LineIcons.map, size: 17),
                            ),
                          ),
                          title: Text(
                            "Supports",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            "Connect with community support",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward,
                              size: 17),
                        ),
                        ListTile(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Alert!",
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
                                            "Yes",
                                            style: GoogleFonts.roboto(
                                                color: Colors.black),
                                          )),
                                    ],
                                  );
                                });
                          },
                          leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: softColor,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(color: Colors.black12)),
                            child: const Center(
                              child: Icon(LineIcons.alternateSignOut, size: 17),
                            ),
                          ),
                          title: Text(
                            "Logout",
                            style: GoogleFonts.roboto(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            "Exit from this place",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          ),
                          trailing: const Icon(CupertinoIcons.chevron_forward,
                              size: 17),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              CupertinoIcons.ellipsis_vertical,
              size: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(img)),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 20,
                  child: InkWell(
                    onTap: () {
                      Provider.of<UpdateController>(context, listen: false)
                          .updateImage(context, ImageSource.gallery);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageUrl.toString(),
                          placeholder: (context, url) => const Icon(
                              CupertinoIcons.person_fill,
                              color: Colors.black54),
                          errorWidget: (context, url, error) =>
                              const Icon(LineAwesomeIcons.user),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 20,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black38),
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.checkmark_seal_fill,
                          size: 18, color: Color(0xFF34B233),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      names.toString(),
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Email : $emails",
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "UID : $jid@jobkar.com",
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "Phone : $phones",
                      style: GoogleFonts.roboto(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(LineAwesomeIcons.linkedin),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(LineAwesomeIcons.github),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(LineAwesomeIcons.graduation_cap, size: 20),
                const SizedBox(width: 3.0),
                Text(
                  "Qualification",
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w600),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Text(
                    "$courses & $branch",
                    style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                  Text(
                    "Year - $years",
                    style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(LineAwesomeIcons.scribd, size: 20),
                const SizedBox(width: 3.0),
                Text(
                  "Experience",
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w600),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(LineAwesomeIcons.map, size: 20),
                const SizedBox(width: 3.0),
                Text(
                  "Location",
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.w600),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_isEmailVerified)
              Text("Cerified") else
                ElevatedButton(
                    onPressed: (){},
                    child:const Text("Verify email")
                ),

          ],
        ),
      ),
    );
  }
}

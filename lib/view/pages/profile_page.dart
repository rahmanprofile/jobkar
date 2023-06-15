import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/controller/data_controller.dart';
import 'package:jobkar/view/pages/details/update_qualification.dart';
import 'package:jobkar/view/pages/details/update_social_category.dart';
import 'package:jobkar/view/pages/details/update_user_address.dart';
import 'package:jobkar/view/pages/details/update_user_details.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
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
  String? linkedin;
  String? github;
  String? cat1;
  String? cat2;
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
        final myLinkedIn = data.data()!['linkedin-url'];
        final myGithub = data.data()!['github-url'];
        final myCat1 = data.data()!['category-1'];
        final myCat2 = data.data()!['category-2'];
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
          linkedin = myLinkedIn;
          github = myGithub;
          cat1 = myCat1;
          cat2 = myCat2;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: InkWell(
                  onTap: (){
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape:const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )
                      ),
                        context: context, builder: (context) {
                      return SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8.0),
                            ListTile(
                              onTap: () {
                                Provider.of<UpdateController>(context, listen: false).updateImage(context, ImageSource.gallery);
                                Navigator.pop(context);
                                //MySnackBar(context, "Image uploading");
                              },
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: softColor,
                                ),
                                child:const Center(
                                  child: Icon(LineAwesomeIcons.image),
                                ),
                              ),
                              title: Text("Gallery",style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),),
                              subtitle: Text("Upload image from gallery",style: GoogleFonts.quicksand(),),
                              trailing: const Icon(CupertinoIcons.chevron_forward),
                            ),
                            ListTile(
                              onTap: () {
                                Provider.of<UpdateController>(context, listen: false).updateImage(context, ImageSource.camera);
                                Navigator.pop(context);
                                //MySnackBar(context, "Image uploading");
                              },
                              leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: softColor,
                                ),
                                child:const Center(
                                  child: Icon(LineAwesomeIcons.camera),
                                ),
                              ),
                              title: Text("Camera",style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),),
                              subtitle: Text("Upload image from camera",style: GoogleFonts.quicksand(),),
                              trailing: const Icon(CupertinoIcons.chevron_forward),
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      );
                    });
                  },
                  child: CircleAvatar(
                    maxRadius: 55,
                    minRadius: 55,
                    backgroundColor: softColor,
                    backgroundImage: NetworkImage(imageUrl.toString()),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(names.toString(),style: GoogleFonts.quicksand(fontSize: 22,fontWeight: FontWeight.bold),),
              Text("Email : ${emails.toString()}",style: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black54),),
              Text("Phone : ${phones.toString()}",style: GoogleFonts.quicksand(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black54),),
              const SizedBox(height: 5),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateUserDetails()));
                },
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: softColor,
                  ),
                  child: const Center(
                    child: Icon(LineAwesomeIcons.pen_nib),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 6.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Credential",style: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),
                    Text("UID : $jid@seeker",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Verified : Account Verified", style: GoogleFonts.quicksand(fontSize: 13,color: CupertinoColors.activeGreen,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5),
                    Text("Status : Live",style: GoogleFonts.quicksand(fontSize: 13,color: CupertinoColors.activeGreen,fontWeight: FontWeight.bold
                    ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 6.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Qualification",style: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                        const Spacer(),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateQualification()));
                            },
                            child: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),
                    Text("College : $colleges",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Course : $courses",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Branch : $branch",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Year : $years",style: GoogleFonts.quicksand(fontSize: 13),),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 6.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Knowledge",style: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateQualification()));
                          },
                          child: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),
                    Text("Skill : $skills",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Experience : $experiences",style: GoogleFonts.quicksand(fontSize: 13),),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 6.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Category",style: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateSocialCategory()));
                          },
                          child: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),
                    Text("Main : $cat1",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Primary : $cat2",style: GoogleFonts.quicksand(fontSize: 13),),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 6.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Address",style: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                        const Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateUserAddress()));
                          },
                          child: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),
                    Text("Area : $area",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("City : $city",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("District : $district",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("State : $state",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("ZipCode : $zipCode",style: GoogleFonts.quicksand(fontSize: 13),),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 6.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Social",style: GoogleFonts.quicksand(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                        const Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateSocialCategory()));
                          },
                          child: const Icon(CupertinoIcons.chevron_forward),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                    ),
                    Text("LinkedIn : $linkedin",style: GoogleFonts.quicksand(fontSize: 13),),
                    const SizedBox(height: 5),
                    Text("Github : $github",style: GoogleFonts.quicksand(fontSize: 13),),
                  ],
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/view/pages/option/pages/components/favourite_internship_component.dart';

class FavouriteInternshipList extends StatefulWidget {
  const FavouriteInternshipList({Key? key}) : super(key: key);

  @override
  State<FavouriteInternshipList> createState() =>
      _FavouriteInternshipListState();
}

class _FavouriteInternshipListState extends State<FavouriteInternshipList> {
  @override
  void initState() {
    __data();
    super.initState();
  }
  final user = FirebaseAuth.instance.currentUser;
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  String? skill;
  String? experience;
  __data() async {
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
        },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:const IconThemeData(color: Colors.black),
        title: Text("Favourite Internship", style: GoogleFonts.roboto(fontSize: 18,color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user!.uid)
              .collection("favourite-internships")
              .where('userId', isEqualTo: user!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FavouriteInternshipComponent(
                    id: snapshot.data!.docs[index].id,
                    salary: snapshot.data!.docs[index]['newSalary'],
                    jobName: snapshot.data!.docs[index]['jobName'],
                    type: snapshot.data!.docs[index]['type'],
                    company: snapshot.data!.docs[index]['company'],
                    salaryEnd: snapshot.data!.docs[index]['endSalary'],
                    range: snapshot.data!.docs[index]['quantity'],
                    onDelete: (){},
                    onView: (){},
                    onApply: (){},
                    onPremium: (){},
                );
              },
            );
          },
        ),
      ),
    );
  }
}

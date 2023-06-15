import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/view/components/loading_widget.dart';
import 'package:jobkar/view/profile/add_project.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileProject extends StatefulWidget {
  const ProfileProject({Key? key}) : super(key: key);

  @override
  State<ProfileProject> createState() => _ProfileProjectState();
}

class _ProfileProjectState extends State<ProfileProject> {
  final __user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(__user!.uid).collection("projects").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.black12,width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: softColor,
                              ),
                              child: const Center(
                                child: Icon(LineAwesomeIcons.github),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.docs[index]['title'],style: GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.black),),
                                Text(snapshot.data!.docs[index]['description'],style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black),),
                                Text(snapshot.data!.docs[index]['source'],style: GoogleFonts.roboto(fontSize: 10,color: Colors.green),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
            );
          }
          return const Center(
            child: LoadingWidget(),
          );
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProject()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        backgroundColor: Colors.blueAccent,
        child: const Icon(CupertinoIcons.add),

      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';

class SearchComponent extends StatefulWidget {
  const SearchComponent({Key? key}) : super(key: key);

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  @override
  void initState() {
    searchController.addListener(() {
      jobName = FirebaseFirestore.instance.collection('post-jobs').where('jobName',isEqualTo: true).snapshots() as String;
    });
    super.initState();
  }
  final searchController = TextEditingController();
  var jobName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Search Page",style: GoogleFonts.roboto(fontSize: 22),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: CupertinoSearchTextField(
                  backgroundColor: Colors.white,
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      jobName = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("post-jobs").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        String textValue = snapshot.data!.docs[index]['jobName'];
                        if (searchController.text.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding:const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                              width: double.infinity,
                              decoration:const BoxDecoration(
                                  color: Colors.white
                              ),
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index]['jobName']),
                                subtitle: Text(snapshot.data!.docs[index]['company']),
                                trailing: const Icon(CupertinoIcons.chevron_forward,size: 18,color: Colors.black),
                              ),
                            ),
                          );
                        } else if (textValue.toLowerCase().contains(searchController.text.toString()) ||
                                   textValue.toUpperCase().contains(searchController.text.toString())) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding:const EdgeInsets.symmetric(horizontal: 6,vertical: 5),
                              width: double.infinity,
                              decoration:const BoxDecoration(
                                  color: Colors.white
                              ),
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index]['jobName']),
                                subtitle: Text(snapshot.data!.docs[index]['company']),
                                trailing: const Icon(CupertinoIcons.chevron_forward,size: 18,color: Colors.black),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

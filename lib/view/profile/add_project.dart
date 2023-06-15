import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/controller/project_controller.dart';
import 'package:jobkar/view/components/loading_widget.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:provider/provider.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final sourceController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
        child: ListView(
          children: [
            Text("Add \nYour Done Project!",style: GoogleFonts.aBeeZee(fontSize: 26,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            Text("Main *",style: GoogleFonts.lato(color: Colors.blueAccent,fontWeight: FontWeight.w600,fontSize: 15),),
            const SizedBox(height: 5),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: softColor,
              ),
              child: TextFormField(
                controller: nameController,
                style: GoogleFonts.roboto(color: Colors.black54),
                decoration: InputDecoration(
                  hintText: "Project Name",
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.roboto(color: Colors.black54),
                  prefixIcon:const Icon(CupertinoIcons.projective,size: 18)
                ),
              ),
            ),

            const SizedBox(height: 10),
            Text("Source *",style: GoogleFonts.lato(color: Colors.blueAccent,fontWeight: FontWeight.w600,fontSize: 15),),
            const SizedBox(height: 5),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: softColor,
              ),
              child: TextFormField(
                controller: sourceController,
                style: GoogleFonts.roboto(color: Colors.black54),
                decoration: InputDecoration(
                    hintText: "Project weblink",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.roboto(color: Colors.black54),
                    prefixIcon:const Icon(CupertinoIcons.projective,size: 18)
                ),
              ),
            ),


            const SizedBox(height: 20),
            Text("Repository *",style: GoogleFonts.lato(color: Colors.blueAccent,fontWeight: FontWeight.w600,fontSize: 15),),
            const SizedBox(height: 5),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: softColor,
              ),
              child: TextFormField(
                maxLines: 5,
                controller: descriptionController,
                style: GoogleFonts.roboto(color: Colors.black54),
                decoration: InputDecoration(
                    hintText: "Project Description",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.roboto(color: Colors.black54),
                    prefixIcon:const Icon(CupertinoIcons.projective,size: 18)
                ),
              ),
            ),

            const SizedBox(height: 120),
            isLoading ? const Center(
              child: LoadingWidget(),
            ) : RoundButton(
                text: "Publish",
                onTap: () async {
                  nameController.clear();
                  sourceController.clear();
                  descriptionController.clear();
                  Provider.of<ProjectController>(context,listen: false).addProject(
                     context,
                      nameController.text,
                      sourceController.text,
                      descriptionController.text,
                  );
                },
                textColor: Colors.white,
                color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    sourceController.dispose();
    super.dispose();
  }
}

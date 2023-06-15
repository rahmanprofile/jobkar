import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/update_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpdateQualification extends StatefulWidget {
  const UpdateQualification({Key? key}) : super(key: key);

  @override
  State<UpdateQualification> createState() => _UpdateQualificationState();
}

class _UpdateQualificationState extends State<UpdateQualification> {
  final collegeController = TextEditingController();
  final courseController = TextEditingController();
  final branchController = TextEditingController();
  final yearController = TextEditingController();
  final skillController = TextEditingController();
  final experienceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Update \nYour Qualification",
                  style: GoogleFonts.quicksand(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "It is important to save correct data else you can face issue?",
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                _textCard("College", "Enter college name",
                    LineAwesomeIcons.university, collegeController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateCollege(context, collegeController.text);
                  collegeController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("Course", "Enter your course name",
                    LineAwesomeIcons.address_book, courseController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateCourse(context, courseController.text);
                  courseController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("Branch", "Which branch you have selected",
                    LineAwesomeIcons.pen_nib, branchController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateBranch(context, branchController.text);
                  branchController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("Skill", "Whats your preferred skill",
                    LineAwesomeIcons.folder, skillController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateSkill(context, skillController.text);
                  skillController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("Year", "Enter your pass-out year",
                    LineAwesomeIcons.folder, yearController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateYear(context, yearController.text);
                  yearController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("Experience", "How much experience do you have",
                    LineAwesomeIcons.user_tie, experienceController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateExperience(context, experienceController.text);
                  experienceController.clear();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textCard(String title, String subTitle, IconData icon,
      TextEditingController controller, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$title ",
              style: GoogleFonts.roboto(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
            ),
            Text(
              "*",
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF512DA8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(color: Colors.black12)),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: TextFormField(
              onChanged: (value) {},
              controller: controller,
              decoration: InputDecoration(
                hintText: subTitle,
                border: InputBorder.none,
                prefixIcon: Icon(icon, size: 18),
                suffixIcon: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                    ),
                    child: const Center(
                      child:
                          Icon(LineAwesomeIcons.sync_icon, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

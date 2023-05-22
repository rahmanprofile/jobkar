import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/controller/data_controller.dart';
import 'package:jobkar/controller/theme_controller.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Qualification extends StatefulWidget {
  const Qualification({Key? key}) : super(key: key);

  @override
  State<Qualification> createState() => _QualificationState();
}

class _QualificationState extends State<Qualification> {
  final collegeController = TextEditingController();
  final courseController = TextEditingController();
  final branchController = TextEditingController();
  final yearController = TextEditingController();
  final experienceController = TextEditingController();
  final skillController = TextEditingController();
  bool _isLoading = false;
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Your \nQualification Details?",
                  style: GoogleFonts.roboto(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF512DA8)),
                ),
                Text(
                  "Enter your qualification details.",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFD81B60)),
                ),
                const SizedBox(height: 25),
                _textBox("College", "Enter college name", collegeController),
                const SizedBox(height: 15),
                _textBox("Course", "Enter course name that you have done",
                    courseController),
                const SizedBox(height: 15),
                _textBox("Branch", "Which branches from you have completed",
                    branchController),
                const SizedBox(height: 15),
                _textBox("Year", "Enter your pass-out year", yearController),
                const SizedBox(height: 15),
                _textBox("Skill", "Enter best skills",
                    skillController),

                const SizedBox(height: 15),
                _textBox("Experience", "How many time you have experience",
                    experienceController),
                const SizedBox(height: 30),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFD81B60),
                        ),
                      )
                    : RoundButton(
                        text: "Submit",
                        onTap: () async {
                          final __pref = await SharedPreferences.getInstance();
                          if (_fromKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                              Provider.of<DataController>(context, listen: false).qualificationData(
                                context,
                                collegeController.text,
                                courseController.text,
                                branchController.text,
                                yearController.text,
                                experienceController.text,
                                skillController.text,
                              );
                              __pref.setString("college", collegeController.text);
                              __pref.setString("course", courseController.text);
                              __pref.setString("branch", branchController.text);
                              __pref.setString("year", yearController.text);
                              __pref.setString("experience", experienceController.text);
                              __pref.setString("skill", skillController.text);
                            });
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        textColor: Colors.white,
                        color: const Color(0xFFD81B60),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textBox(
      String title, String subTitle, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFD81B60)),
            ),
            Text(
              " *",
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF512DA8)),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: softColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return "please enter your correct details";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: subTitle,
                  hintStyle: GoogleFonts.roboto(fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/mysnackbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';
import '../../../controller/update_controller.dart';

class UpdateSocialCategory extends StatefulWidget {
  const UpdateSocialCategory({super.key});

  @override
  State<UpdateSocialCategory> createState() => _UpdateSocialCategoryState();
}

class _UpdateSocialCategoryState extends State<UpdateSocialCategory> {
  final githubController = TextEditingController();
  final linkedInController = TextEditingController();
  String? categoryOne;
  String? categoryTwo;
  var listCategory = [
    "Accountant",
    "Software Development",
    "Web Development",
    "Sales & Marketing",
    "Digital Marketing",
    "Delivery",
    "Marketing Management",
    "Financial Analyst",
    "Business Analyst",
    "Real State",
    "Block Chain",
    "Frontend Development",
    "Backend Development",
    "Wordpress Developer",
    "Web Designer",
    "Software Designer",
    "Human Resource",
    "Project Manager",
    "Business Development Executive",
    "Full Stack",
    "Architect",
    "Machine Learning",
    "Consultant",
    "AutoCad",
    "Data Scientist",
    "Cold Calling",
    "Others"
  ];
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
                  "Update \nYour Social Route \nConnections",
                  style: GoogleFonts.quicksand(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "It is important to save correct data else you can face issue?",
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                _textCard("LinkedIn", "Enter your linkedin url",
                    LineAwesomeIcons.linkedin, linkedInController, () {
                      Provider.of<UpdateController>(context, listen: false)
                          .updateLinkedinUrl(context, linkedInController.text);
                      linkedInController.clear();
                    }),
                const SizedBox(height: 10),
                _textCard("Github", "Enter your github url",
                    LineAwesomeIcons.github, githubController, () {
                      Provider.of<UpdateController>(context, listen: false)
                          .updateGithubUrl(context, githubController.text);
                      githubController.clear();
                    }),
                const SizedBox(height: 10),
                _titleText("Category-1"),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButton<String>(
                            value: categoryOne,
                            underline: Container(),
                            hint: const Text("Select your first job Category"),
                            onChanged: (String? newValue) {
                              // Make the onChanged callback accept nullable String
                              setState(() {
                                categoryOne = newValue;
                              });
                            },
                            items: listCategory.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: () {
                        Provider.of<UpdateController>(context,listen: false).updateCategoryOne(context, categoryOne.toString());
                      },
                      child: Container(
                        height: 45,
                        width: 50,
                        decoration:const BoxDecoration(
                          color: Colors.pink,
                        ),
                        child: const Center(
                          child: Icon(LineAwesomeIcons.sync_icon,color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
               

                const SizedBox(height: 10),
                _titleText("Category-2"),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DropdownButton<String>(
                            value: categoryTwo,
                            underline: Container(),
                            hint: const Text("Select your second job Category"),
                            onChanged: (String? newValue) {
                              // Make the onChanged callback accept nullable String
                              setState(() {
                                categoryTwo = newValue;
                              });
                            },
                            items: listCategory.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: (){
                        Provider.of<UpdateController>(context,listen: false).updateCategoryTwo(context, categoryTwo.toString());
                      },
                      child: Container(
                        height: 45,
                        width: 50,
                        decoration:const BoxDecoration(
                          color: Colors.pink,
                        ),
                        child: const Center(
                          child: Icon(LineAwesomeIcons.sync_icon,color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _titleText(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ",
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFD81B60),
          ),
        ),
        Text(
          "*",
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF512DA8),
          ),
        ),
      ],
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

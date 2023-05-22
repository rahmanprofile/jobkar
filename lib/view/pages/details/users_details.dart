import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/data_controller.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:jobkar/view/home.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../controller/constant.dart';

class UsersDetails extends StatefulWidget {
  const UsersDetails({Key? key}) : super(key: key);

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  bool isLoading = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Your \n'Contact' \ndetails are required",
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    "Enter your correct details otherwise recruiter can't access you?",
                    style: GoogleFonts.roboto(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 25),
                  _titleText("Name"),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: whiteColor,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return "enter your valid name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your nick name",
                        prefixIcon: Icon(
                          LineAwesomeIcons.user,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _titleText("Phone"),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: whiteColor,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return "enter your 10 digit number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone number",
                        prefixIcon: Icon(
                          LineAwesomeIcons.phone,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _titleText("Email"),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: whiteColor,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return "enter your correct email";
                        } else if (!value.contains("@")) {
                          return "enter correct email format character @";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your unique email",
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: mainColor),
                        )
                      : RoundButton(
                          text: "Continue",
                          onTap: () async {
                            final pref = await SharedPreferences.getInstance();
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                Provider.of<DataController>(context,
                                        listen: false)
                                    .personalData(
                                  context,
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                );
                                pref.setString("name", nameController.text);
                                pref.setString("email", emailController.text);
                                pref.setString("phone", phoneController.text);
                              });
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          textColor: Colors.white,
                          color: const Color(0xFF512DA8),
                        ),
                  const SizedBox(height: 15.0),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.roboto(
                              color: const Color(0xFFD81B60),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),),);
                          },
                          child: Text(
                            "Skip",
                            style: GoogleFonts.roboto(
                                color:const  Color(0xFF4527A0),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.clear();
    super.dispose();
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
}

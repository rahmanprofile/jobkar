import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/update_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpdateUserDetails extends StatefulWidget {
  const UpdateUserDetails({Key? key}) : super(key: key);

  @override
  State<UpdateUserDetails> createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final jidController = TextEditingController();
  final githubController = TextEditingController();
  final linkedinController = TextEditingController();
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
                  "Update \nYour Personal details",
                  style: GoogleFonts.roboto(
                      fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Update your job location to see job in your area.",
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                _textCard("Name", "Enter your nick name",
                    LineAwesomeIcons.user, nameController, () {
                  Provider.of<UpdateController>(context, listen: false).updateName(context, nameController.text);
                  nameController.clear();
                    }),
                const SizedBox(height: 10),
                _textCard("Email", "Enter your professional email", LineAwesomeIcons.envelope,
                    emailController, () {
                      Provider.of<UpdateController>(context, listen: false).updateEmail(context, emailController.text);
                      emailController.clear();
                    }),
                const SizedBox(height: 10),
                _textCard("Jid", "Change your jobkar id",
                    LineAwesomeIcons.identification_badge, jidController, () {
                      Provider.of<UpdateController>(context, listen: false).updateJid(context, jidController.text);
                      jidController.clear();
                    }),
                const SizedBox(height: 10),
                _textCard("Github", "Enter your github url",
                    LineAwesomeIcons.github, githubController, () {
                      Provider.of<UpdateController>(context, listen: false).updateGithubUrl(context, githubController.text);
                      githubController.clear();
                    }),
                const SizedBox(height: 10),
                _textCard("Linkedin", "Enter your linkedin url",
                    LineAwesomeIcons.linkedin, linkedinController, () {
                      Provider.of<UpdateController>(context, listen: false).updateLinkedinUrl(context, linkedinController.text);
                      linkedinController.clear();
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(LineAwesomeIcons.redo),
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    jidController.dispose();
    super.dispose();
  }
}

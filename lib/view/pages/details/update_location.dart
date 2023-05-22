import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/update_controller.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({Key? key}) : super(key: key);

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
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
                  "Update \nYour Current Location",
                  style: GoogleFonts.roboto(
                      fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Update your job location to see job in your area.",
                  style: GoogleFonts.roboto(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                _textCard("Area", "Enter your area name",
                    LineAwesomeIcons.university, areaController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateArea(context, areaController.text);
                  areaController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("City", "What your good city", LineAwesomeIcons.city,
                    cityController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateCity(context, cityController.text);
                  cityController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("District", "Which district you belong",
                    LineAwesomeIcons.building, districtController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateDistrict(context, districtController.text);
                  districtController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("State", "Whats your country state",
                    LineAwesomeIcons.map, stateController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateState(context, stateController.text);
                  stateController.clear();
                }),
                const SizedBox(height: 10),
                _textCard("Zipcode", "What your zipcode",
                    LineAwesomeIcons.code_branch, zipController, () {
                  Provider.of<UpdateController>(context, listen: false)
                      .updateZip(context, zipController.text);
                  zipController.clear();
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
}

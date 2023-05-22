import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/controller/data_controller.dart';
import 'package:jobkar/controller/theme_controller.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({Key? key}) : super(key: key);

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
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
                const SizedBox(height: 120),
                Text(
                  "Your \nBeautiful area name",
                  style: GoogleFonts.sansita(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF512DA8)),
                ),
                Text(
                  "What your nice place where you belong.",
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFD81B60)),
                ),
                const SizedBox(height: 25),
                _textBox("Area", "Which area you are locate", areaController),
                const SizedBox(height: 15),
                _textBox(
                    "City", "Enter your current city name", cityController),
                const SizedBox(height: 15),
                _textBox("District", "Which famous district you belong",
                    districtController),
                const SizedBox(height: 15),
                _textBox("State", "Enter your state name", stateController),
                const SizedBox(height: 30),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFD81B60),
                        ),
                      )
                    : RoundButton(
                        text: "Complete",
                        onTap: () async {
                          final __pref = await SharedPreferences.getInstance();
                          if (_fromKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                              Provider.of<DataController>(context,
                                      listen: false)
                                  .location(
                                      context,
                                      cityController.text,
                                      areaController.text,
                                      districtController.text,
                                      stateController.text,
                                "",
                              );
                              __pref.setString("city", cityController.text);
                              __pref.setString("area", areaController.text);
                              __pref.setString(
                                  "district", districtController.text);
                              __pref.setString("state", stateController.text);
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

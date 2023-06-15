import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/phone_controller.dart';
import 'package:jobkar/view/components/loading_widget.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final _phoneTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 60,
            right: 10,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.zero,
                      topLeft: Radius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "What is \nyour phone number?",
                    style: GoogleFonts.sansita(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  //Image.asset("assets/img/log.png",height: 150,width: 150),
                  const SizedBox(height: 20),
                  Text(
                    "Tap 'Send Code' to get an sms for confirmation to help \n you to use our services. We would like your number \nto connect with us.",
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        height: 45,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "+91",
                            style: GoogleFonts.jost(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.black12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Center(
                              child: TextFormField(
                                controller: _phoneTextController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == "" || value!.isEmpty) {
                                    return "Enter your 10 digit mobile number";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                style: GoogleFonts.jost(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                                decoration: InputDecoration(
                                  hintText: "Enter 10 digit phone number",
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.jost(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const Center(
                          child: LoadingWidget(),
                        )
                      : RoundButton(
                          text: "Send Code",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {_isLoading = true;
                                Provider.of<PhoneController>(context,listen: false).signInWithPhoneNumber(
                                        context, _phoneTextController.text);
                              });
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneTextController.dispose();
    super.dispose();
  }
}

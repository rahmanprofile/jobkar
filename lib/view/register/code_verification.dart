import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/phone_controller.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../controller/constant.dart';

class CodeVerification extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final Duration timeOutDuration;
  const CodeVerification({
    Key? key,
    required this.verificationId,
    required this.timeOutDuration,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  Timer? _timer;
  int _countDown = 0;
  bool _isCountDown = false;

  Future<void> _resendOTP() async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+91${widget.phoneNumber}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException x) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: widget.timeOutDuration,
    );
  }

  void _startCountDown() {
    _countDown = widget.timeOutDuration.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countDown--;
      });
      if (_countDown <= 0) {
        _isCountDown = false;
        _timer!.cancel();
      }
    });
  }

  final auth = FirebaseAuth.instance;
  final _phoneNumberController = TextEditingController();
  bool _isLoading = false;
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Stack(
          children: [
            Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Verify \nyour phone number?",
                      style: GoogleFonts.sansita(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF512DA8))),
                  const SizedBox(height: 15.0),
                  Text(
                      "Check your SMS message. We've send you \nthe pin at +91${widget.phoneNumber}",
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 15.0),
                  Pinput(
                    length: 6,
                    controller: _phoneNumberController,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
                    defaultPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: mainColor),
                        )
                      : RoundButton(
                          text: "Confirm",
                          onTap: () async {
                            if (_fromKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                                Provider.of<PhoneController>(context, listen: false).verifyPhoneNumber(
                                        context,
                                        widget.verificationId,
                                        _phoneNumberController.text);
                              },
                              );
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          textColor: Colors.white,
                          color: const Color(0xFFD81B60),
                        ),
                  const SizedBox(height: 25.0),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "After confirmation you agree our all types of terms &",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        Text(
                          "policy and conditions & included service charges.",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If it not has received Sms?  ",
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      InkWell(
                        onTap: !_isCountDown
                            ? () {
                                _resendOTP();
                                _isCountDown = true;
                                _startCountDown();
                              }
                            : null,
                        child: Text(
                          _isCountDown ? "$_countDown" : "Resend Code",
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF512DA8),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFF512DA8),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50)),
                      color: Color(0xFFD81B60),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

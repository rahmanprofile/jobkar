import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/view/components/round_button.dart';

class StudyForm extends StatefulWidget {
  const StudyForm({Key? key}) : super(key: key);

  @override
  State<StudyForm> createState() => _StudyFormState();
}

class _StudyFormState extends State<StudyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: softColor,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/img/cute.png"))),
                    ),
                    const SizedBox(height: 0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sunaina Yomik",
                          style: GoogleFonts.ptSans(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Head of Premium Team",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Text(
                'About',
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                'Apply job with Premium.',
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              const SizedBox(height: 15.0),
              Text(
                'Information',
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                "Before apply this form read this guidelines. \n1. When you applied job with premium it takes charges ₹25. \n2. In which our team will provide you to conduct an interview as well as good jobs with highest salary in good company. \n3. We take a little bit more time around one or two weeks for to conduct an interview, it may be one or two days. \n4. Our last stage is to connect with you an interview with good company, where you can achieve your goal. \n5. If you fail in the interview, it is your responsibility, why you failed in interviews remember each points. \n6. If we can not conduct you with an interviewer in 15 days with good company, We will refunded your money in your account after cut 18% Of GST Charges.",
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              const SizedBox(height: 15),
              Text(
                'Status',
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                "When you 'Continue' or Applied this form you agree our all premium services and you have read carefully read our services.",
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
              const SizedBox(height: 20),
              RoundButton(
                text: "Continue",
                onTap: () {},
                textColor: Colors.white,
                color: const Color(0xFFC2185B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

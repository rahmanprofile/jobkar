import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';

class TechnicalSupport extends StatefulWidget {
  const TechnicalSupport({Key? key}) : super(key: key);

  @override
  State<TechnicalSupport> createState() => _TechnicalSupportState();
}

class _TechnicalSupportState extends State<TechnicalSupport> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Text(
                  "Our Team \n24X7 Time Active!",
                  style: GoogleFonts.roboto(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Technical Support",
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Text(
                        "Account registration issue",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Data error issue",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Public violation issue",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Scams and fraud issue",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Other technical issue ",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Contact Us :",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "technical@jobkar.net",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Premium Jobs",
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Text(
                        "Delay in job response",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "No, reply from recruiter",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Recruiter scams and fraud",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Recruiter behaviour issue",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Other premium issue ",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Contact Us :",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "premium@jobkar.net",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payments",
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Text(
                        "Premium job apply issue",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Server issue in payment",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Takes to much time in payment",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "can't not take payments",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Other payments issue ",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Contact Us :",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          const Spacer(),
                          Text(
                            "payment@jobkar.net",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

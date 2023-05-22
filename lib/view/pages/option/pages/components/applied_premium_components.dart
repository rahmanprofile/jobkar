import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';

class AppliedPremiumComponents extends StatelessWidget {
  final String id;
  final String salary;
  final String salaryEnd;
  final String jobName;
  final String company;
  final String range;
  final String type;
  final String imageUrl;
  const AppliedPremiumComponents({
    Key? key,
    required this.id,
    required this.salary,
    required this.jobName,
    required this.type,
    required this.company,
    required this.salaryEnd,
    required this.range,
    required this.imageUrl,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: softColor,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child:const Center(
                      child: Icon(CupertinoIcons.eyeglasses),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(company,style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w300),),
                      Text(jobName,style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w400),),
                      Text("₹$salary - ₹$salaryEnd",style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black54),),
                      Text("$type - $range Person",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400, color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

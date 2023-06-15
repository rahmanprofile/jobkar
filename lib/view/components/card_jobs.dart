import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';

class CardJob extends StatelessWidget {
  final String id;
  final String salary;
  final String salaryEnd;
  final String jobName;
  final String company;
  final String range;
  final String orgLogo;
  final String type;
  final VoidCallback onApply;
  final VoidCallback onPremium;
  final VoidCallback onFav;
  final VoidCallback onView;
  const CardJob({
    Key? key,
    required this.id,
    required this.salary,
    required this.jobName,
    required this.type,
    required this.company,
    required this.salaryEnd,
    required this.range,
    required this.onFav,
    required this.orgLogo,
    required this.onView,
    required this.onApply,
    required this.onPremium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: onView,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(2),
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
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: orgLogo.toString(),
                          placeholder: (context, url) => const Icon(CupertinoIcons.eyeglasses,color: Colors.black54,size: 40),
                          errorWidget: (context, url, error) => const Icon(CupertinoIcons.eyeglasses),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company,
                          style: GoogleFonts.roboto(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          jobName,
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "₹$salary - ₹$salaryEnd",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        Text(
                          "$type - $range Person",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: onApply,
                      child: Container(
                        height: 25,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                            border: Border.all(color: Colors.black12)),
                        child: Center(
                          child: Text(
                            "Apply",
                            style: GoogleFonts.roboto(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    InkWell(
                      onTap: onPremium,
                      child: Container(
                        height: 25,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: blueColor,
                        ),
                        child: Center(
                          child: Text(
                            "Apply with Premium",
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onFav,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: softColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(CupertinoIcons.heart,
                              size: 15, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumApplyUserComponent extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;
  final String phone;
  final String skill;
  final String experience;
  final String jobName;
  const PremiumApplyUserComponent({Key? key,
  required this.imageUrl,
    required this.name,
    required this.email,
    required this.phone,
    required this.jobName,
    required this.skill,
    required this.experience,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl.toString(),
                  placeholder: (context, url) => const Icon(CupertinoIcons.eyeglasses,color: Colors.black54,size: 40),
                  errorWidget: (context, url, error) => const Icon(CupertinoIcons.eyeglasses),
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),),
                Text("Email : $email",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black54),),
                Text("Phone : $phone",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black54),),
                Text("Skill : $skill",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black54),),
                Text("JobName : $jobName",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black54),),
                Text("Experience : $experience",style: GoogleFonts.roboto(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black54),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

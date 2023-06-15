import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/view/register/phone_authentication.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    _listImages;
    super.initState();
  }

  final List<AssetImage> _listImages = [
    const AssetImage("assets/img/women.png"),
    const AssetImage("assets/img/company.png"),
    const AssetImage("assets/img/opt.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/img/women.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Get India's \nHigh pay jobs \neasily.",
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CompanyPage()));
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blueAccent,
                      border: Border.all(color: Colors.blueAccent)),
                  child: Center(
                    child: Text(
                      "Continue",
                      style:
                          GoogleFonts.roboto(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyPage extends StatelessWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/img/company.png")),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Top World \nMNC'S Company \nOur Partner.",
                style: GoogleFonts.roboto(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Don't miss this opportunity!",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              const SizedBox(height: 60),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GuideLinesPage()));
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blueAccent,
                      border: Border.all(color: Colors.blueAccent)),
                  child: Center(
                    child: Text(
                      "Let's grab Opportunity",
                      style:
                          GoogleFonts.roboto(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideLinesPage extends StatefulWidget {
  const GuideLinesPage({Key? key}) : super(key: key);

  @override
  State<GuideLinesPage> createState() => _GuideLinesPageState();
}

class _GuideLinesPageState extends State<GuideLinesPage> {
  @override
  void initState() {
    imagesItems = "assets/img/opt.jpg";
    super.initState();
  }
  String? imagesItems;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(imagesItems.toString()))),
            ),
          ),
          const SizedBox(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Millions",
                style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "Jobs of opportunity",
                style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              Center(
                  child: Text(
                "Jobkar uses premium functionality",
                style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )),
              Center(
                  child: Text(
                "To get best jobs with highest salary in a good",
                style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )),
              Center(
                  child: Text(
                "Company always use apply with premium.",
                style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )),
            ],
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PhoneAuth()));
            },
            child: Container(
              height: 45,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                child:
                    Icon(CupertinoIcons.arrow_right, color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

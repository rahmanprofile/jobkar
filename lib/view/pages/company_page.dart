import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/view/components/round_button.dart';
import '../register/phone_authentication.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  List<String> imageList = [
    "assets/com/google.png",
    "assets/com/hcl.png",
    "assets/com/paytm.png",
    "assets/com/amazon.png",
    "assets/com/hp.png",
    "assets/com/netflix.png",
    "assets/com/apple.png",
    "assets/com/tcs.png",
    "assets/com/WIT_BIG.png",
    "assets/com/flipkart.png",
    "assets/com/infosys.png",
    "assets/com/microsoft.png",
  ];
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                "Empowering \nMNCs Worldwide!",
                style: GoogleFonts.roboto(
                    fontSize: 27, fontWeight: FontWeight.w600),
              ),
              Text(
                "Our trust your progress always go truth.",
                style: GoogleFonts.sansita(color: const Color(0xFFD81B60),
                    fontSize: 17, fontWeight: FontWeight.w200),
              ),
              const SizedBox(height: 10.0),
              GridView.builder(
                  itemCount: imageList.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      width: MediaQuery.of(context).size.width * 0.50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: softColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(imageList[index]),
                      ),
                    );
                  }),
              const Spacer(),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFD81B60),
                      ),
                    )
                  : RoundButton(
                      text: "Continue",
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhoneAuth()),
                              (route) => false);
                        });
                      },
                      textColor: Colors.white,
                      color: const Color(0xFF512DA8),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

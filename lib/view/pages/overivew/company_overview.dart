import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/controller/mysnackbar.dart';

class CompanyOverview extends StatefulWidget {
  const CompanyOverview({Key? key}) : super(key: key);

  @override
  State<CompanyOverview> createState() => _CompanyOverviewState();
}

class _CompanyOverviewState extends State<CompanyOverview> {
  List<String> itemList = [
    "assets/com/google.png",
    "assets/com/amazon.png",
    "assets/com/apple.png",
    "assets/com/microsoft.png",
    "assets/com/netflix.png",
    "assets/com/flipkart.png",
    "assets/com/hp.png",
    "assets/com/tcs.png",
    "assets/com/genpact.png",
    "assets/com/WIT_BIG.png",
    "assets/com/dell.png",
    "assets/com/hcl.png",
    "assets/com/paytm.png",
    "assets/com/uber.png",
    "assets/com/zerodha.png",
    "assets/com/infosys.png",
    "assets/com/accenture.png",
    "assets/com/asus.png",
    "assets/com/autodesk.png",
    "assets/com/cisco.png",
    "assets/com/facebook.png",
    "assets/com/mahindra.png",
    "assets/com/ibm.png",
    "assets/com/intel.png",
    "assets/com/nvidia.png",
    "assets/com/reddit.png",
    "assets/com/samsung.png",
    "assets/com/salesforce.png",
    "assets/com/sap.png",
    "assets/com/skype.png",
    "assets/com/shopify.png",
    "assets/com/slack.png",
    "assets/com/spotify.png",
    "assets/com/tencent.png",
  ];
  List<String> nameList = [
    "Google Workspace",
    "Amazon",
    "Apple.inc",
    "Microsoft Technology",
    "Netflix Entertainment",
    "Flipkart",
    "Hewlett Packard",
    "Tata Group",
    "Genpact",
    "Wipro",
    "Dell Technology",
    "HCL Technology",
    "Paytm",
    "Uber",
    "Zerodha",
    "Infosys",
    "Accenture",
    "Asus",
    "Autodesk",
    "CISCO",
    "Facebook",
    "Mahindra",
    "IBM",
    "Intel",
    "Nvidia",
    "Reddit",
    "Samsung",
    "Salesforce",
    "Sap",
    "skype",
    "Shopify",
    "Slack",
    "Spotify",
    "Tencent",
  ];
  List<String> titleList = [
    "Google Development",
    "Amazon Retailer",
    "Apple Product Development",
    "Microsoft sales & service",
    "Netflix Management",
    "Flipkart Development",
    "HP Technology Development",
    "Tata Development Group",
    "Genpact Technology",
    "Wipro Service",
    "Dell Technology",
    "HCL Technology",
    "Paytm Service Management",
    "Uber Technology",
    "Zerodha Finance",
    "Infosys Technology",
    "Accenture",
    "Asus Product",
    "Autodesk Adobe Service",
    "CISCO Technology",
    "Facebook",
    "Mahindra Technology",
    "IBM Creative Technology",
    "Intel Service",
    "Nvidia Technology",
    "Reddit Service",
    "Samsung Technology",
    "Salesforce Management",
    "SAP Technology",
    "Skype Communication",
    "Shopify Development",
    "Slack Community",
    "Spotify Music",
    "Tencent Technology",
  ];
  final searchController = TextEditingController();
  var searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CupertinoSearchTextField(
            controller: searchController,
            backgroundColor: Colors.grey[200],
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            String searchItem = nameList[index];
            if (searchController.text.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 115,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(itemList[index]),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titleList[index],
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  nameList[index],
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "Apply for next opportunity?",
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                MySnackBar(context, "Applied successfully");
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (searchItem
                    .toLowerCase()
                    .contains(searchController.text.toString()) ||
                searchItem
                    .toUpperCase()
                    .contains(searchController.text.toString())) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  height: 115,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(itemList[index]),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  titleList[index],
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  nameList[index],
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "Apply for next opportunity?",
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                MySnackBar(context, "Applied successfully");
                              },
                              child: Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

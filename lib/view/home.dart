import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobkar/view/pages/employee_page.dart';
import 'package:jobkar/view/pages/internship_page.dart';
import 'package:jobkar/view/pages/main_page.dart';
import 'package:jobkar/view/pages/profile_page.dart';
import 'package:jobkar/view/placement/placement.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _optionWidget = const [
    MainPage(),
    PlacementPlace(),
    EmployeePage(),
    InternshipPage(),
    ProfilePage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _optionWidget.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.roboto(fontSize: 10,fontWeight: FontWeight.w500),
        backgroundColor: Colors.white,
        unselectedLabelStyle: GoogleFonts.roboto(fontSize: 10,fontWeight: FontWeight.w500),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cube_box),
            label: "Recommend",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.staroflife),
            label: "Profession",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.app_badge),
            label: "Internship",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
          ),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

MaterialColor primarySwatch = const MaterialColor(
  0xFF6200EE,
  <int, Color>{
    50: Color(0xFFEDE7F6),
    100: Color(0xFFD1C4E9),
    200: Color(0xFFB39DDB),
    300: Color(0xFF9575CD),
    400: Color(0xFF7E57C2),
    500: Color(0xFF6200EE),
    600: Color(0xFF5E35B1),
    700: Color(0xFF512DA8),
    800: Color(0xFF4527A0),
    900: Color(0xFF311B92),
  },
);

MaterialColor accentColor = const MaterialColor(
  0xFFFF4081,
  <int, Color>{
    50: Color(0xFFFFE0E6),
    100: Color(0xFFFFB2C2),
    200: Color(0xFFFF809F),
    300: Color(0xFFFF4D79),
    400: Color(0xFFFF3075),
    500: Color(0xFFFF4081),
    600: Color(0xFFE91E63),
    700: Color(0xFFD81B60),
    800: Color(0xFFC2185B),
    900: Color(0xFFAD1457),
  },
);

ThemeData appTheme = ThemeData(
  primarySwatch: primarySwatch,
  hintColor: accentColor,
  scaffoldBackgroundColor: const Color(0xFFF4F4F4),
  fontFamily: 'Roboto',
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      color: primarySwatch[500],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ), systemOverlayStyle: SystemUiOverlayStyle.light),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: accentColor,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline2: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline3: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline4: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline6: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontFamily: 'Roboto',
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
    ),
    caption: TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
    ),
  ),
);

Color cardBackgroundColor = Colors.white;
Color? cardBorderColor = Colors.grey[300];
Color? cardShadowColor = Colors.grey[200];


MaterialColor primaryNewSwatch = const MaterialColor(
  0xFF0D47A1,
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(0xFF2196F3),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  },
);

MaterialColor accentNewColor = const MaterialColor(
  0xFF2979FF,
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(0xFF2196F3),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  },
);

ThemeData appNewTheme = ThemeData(
  primarySwatch: primaryNewSwatch,
  hintColor: accentNewColor,
  scaffoldBackgroundColor: const Color(0xFFF4F4F4),
  fontFamily: 'Roboto',
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
      color: primaryNewSwatch[500],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ), systemOverlayStyle: SystemUiOverlayStyle.light),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: accentNewColor,
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline2: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline3: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline4: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline5: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    headline6: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontFamily: 'Roboto',
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
    ),
    caption: TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
    ),
  ),
);


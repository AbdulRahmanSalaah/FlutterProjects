import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
Color primary = const Color(0xffbb86fc);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: white,
  );

  // scaffoldBackgroundColor: Colors.black,

  // backgroundColor: Colors.grey[900],
  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    brightness: Brightness.dark,
  );
}

TextStyle get headingStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : darkGreyClr,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get subHeadingStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : darkGreyClr,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get titleStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : darkGreyClr,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get subTitleStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : darkGreyClr,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}

TextStyle get bodyStyle {
  return TextStyle(
    color: Get.isDarkMode ? Colors.white : darkGreyClr,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}

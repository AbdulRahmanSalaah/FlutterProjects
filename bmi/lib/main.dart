// import 'package:bmi_cal/Config/Theme.dart';
// import 'package:bmi_cal/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Config/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI CALCULATOR',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MyHomePage(),
    );
  }
}

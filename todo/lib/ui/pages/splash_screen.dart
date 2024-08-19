import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
              'Lottie/Animation - 1724006720572.json',
              // width: 200,
              // height: 200,
              // // fit: BoxFit.fill,
            ),
          )
        ],
      ),
      nextScreen: const HomePage(),
      splashIconSize: 400,
      backgroundColor: Get.isDarkMode ? Colors.grey[900]! : Colors.white,
      duration: 1200,
    );
  }
}

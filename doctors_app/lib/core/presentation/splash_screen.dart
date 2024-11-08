import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../data/networking/api_constants.dart';
import '../helper/shared_pref_helper.dart';
import '../routing/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainPage();
  }

  void _navigateToMainPage() async {
    await Future.delayed(
        const Duration(milliseconds: 1500)); // Adjust the duration as needed

    // GoRouter.of(context).pushReplacement(AppRoutes.onboardingRoute);
    rememberMe = await SharedPrefHelper.getBool(SharedPrefKeys.userToken);
    userNametohome =
        await SharedPrefHelper.getString(SharedPrefKeys.userName) ?? 'User';
    debugPrint('Remember Me: $rememberMe');
    if (rememberMe) {
      GoRouter.of(context).pushReplacement(AppRoutes.homeRoute);
    } else {
      GoRouter.of(context).pushReplacement(AppRoutes.onboardingRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Splash_Screen.png',
              width: 300.w,
              height: 800.h,
            ),
          ],
        ),
      ),
    );
  }
}

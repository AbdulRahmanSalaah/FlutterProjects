import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/app_routes.dart';

import '../../resources/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToMainPage();
    });
  }

  void _navigateToMainPage() async {
    await Future.delayed(
        const Duration(milliseconds: 3000)); // Adjust the duration as needed

        // mounted means  that the widget is still part of the widget tree and has not been disposed of yet 
    if (mounted) {
      // Ensure the widget is still mounted before navigating
      GoRouter.of(context).goNamed(AppRoutes.moviesRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Lottie.asset('assets/lottie/splash.json'),
      ),
    );
  }
}

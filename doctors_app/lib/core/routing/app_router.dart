import 'package:doctors_app/core/presentation/splash_screen.dart';
import 'package:doctors_app/core/routing/app_routes.dart';
import 'package:doctors_app/features/home/domain/usecases/get_specializations_usecase.dart';
import 'package:doctors_app/features/home/presentation/controller/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/domain/usecases/login_usecase.dart';
import '../../features/auth/login/presentation/controller/cubit/login_cubit.dart';
import '../../features/auth/login/presentation/login_screen.dart';
import '../../features/auth/signup/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/signup/presentation/controller/cubit/sign_up_cubit.dart';
import '../../features/auth/signup/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/on_boarding_screen.dart';
import '../services/service_locator.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingRoute,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnBoardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade transition
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.signUpRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => SignUpCubit(
            getIt.get<SignUpUsecase>(),
          ),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.loginRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(
            getIt.get<LoginUseCase>(),
          ),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.homeRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<GetSpecializationsUsecase>(),
          )..getSpecializations(),
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}

import 'package:doctors_app/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/presentation/login_screen.dart';
import '../../features/onboarding/presentation/on_boarding_screen.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        name: AppRoutes.loginRoute ,
        path: AppRoutes.loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}

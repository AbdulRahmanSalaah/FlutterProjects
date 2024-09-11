import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/app_router.dart';
import '../../resources/app_routes.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_values.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    log('MainPage build method triggered');
    // final String location = router.routerDelegate.currentConfiguration.fullPath;
    // final String location = router.routerDelegate.currentConfiguration.uri.toString();
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.movies,
            icon: Icon(
              Icons.movie_creation_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.shows,
            icon: Icon(
              Icons.tv_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.search,
            icon: Icon(
              Icons.search_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.watchlist,
            icon: Icon(
              Icons.bookmark_rounded,
              size: AppSize.s20,
            ),
          ),
        ],
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    log('Location: $location');

    if (location == moviesPath) {
      return 0;
    }
    if (location.startsWith(tvShowsPath)) {
      return 1;
    }
    if (location == searchPath) {
      return 2;
    }
    if (location == watchlistPath) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.moviesRoute, extra: UniqueKey());
        break;
      case 1:
        context.goNamed(AppRoutes.tvShowsRoute, extra: UniqueKey());
        break;
      case 2:
        context.goNamed(AppRoutes.searchRoute, extra: UniqueKey());
        break;
      case 3:
        // Always force a rebuild when navigating to the Watchlist by passing a UniqueKey
        context.goNamed(AppRoutes.watchlistRoute, extra: UniqueKey());
        break;
    }
  }
}

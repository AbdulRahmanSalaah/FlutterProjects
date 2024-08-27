import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: AppBar(
        automaticallyImplyLeading: false, // Remove default leading back button

        title: Image.asset(
          'assets/images/Logo.png',
          height: 18,
          // width: 100,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSearhView,);
              
            },
            icon: const Icon(FontAwesomeIcons.magnifyingGlass,
                size: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

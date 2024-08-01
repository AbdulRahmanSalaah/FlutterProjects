import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class ThemeChangeBtn extends StatelessWidget {
  const ThemeChangeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              themeController.chnageTheme();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // this is the icon for the theme change button
                // svg  is used for the icon  which is imported from flutter_svg package
                // this package is used to import svg files  in the flutter project
                SvgPicture.asset(
                  "assets/icons/light.svg",
                  color: themeController.isDark.value
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 40,
                ),
                SvgPicture.asset(
                  "assets/icons/dark.svg",
                  color: themeController.isDark.value
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

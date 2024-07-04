import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    // Check if the device is in dark mode
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),

      // The FractionallySizedBox is used to create a bar that fills the available space
      child: FractionallySizedBox(
        heightFactor: fill,
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDarkMode
                ? Theme.of(context).colorScheme.secondary
                : const Color.fromARGB(155, 63, 125, 156),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';

import 'Colors.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    // background: lBgColor,
    primary: lPrimaryColor,
    onSurface: lFontColor,
    primaryContainer: lDivColor,
    onPrimaryContainer: lFontColor,
    onSecondaryContainer: lLableColor,
  ),
  scaffoldBackgroundColor: lBgColor, // Explicit scaffold background color
);
var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    // surface: dBgColor,
    primary: dPrimaryColor,
    onSurface: dFontColor,
    primaryContainer: dDivColor,
    onPrimaryContainer: dFontColor,
    onSecondaryContainer: dLableColor,
  ),
  scaffoldBackgroundColor: dBgColor, // Explicit scaffold background color
);

import 'package:flutter/material.dart';

final myColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 12, 159, 233),
);

final lightTheme = ThemeData().copyWith(
  colorScheme: myColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 61, 158, 206),
    foregroundColor: myColorScheme.onTertiaryContainer,
    titleTextStyle: TextStyle(
      color: myColorScheme.onPrimary,
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),

    // The iconTheme is used to specify the color of the icons in the app bar
    iconTheme: IconThemeData(color: myColorScheme.onPrimary),
  ),
  cardTheme: CardTheme(
    color: myColorScheme.onPrimary,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: myColorScheme.onPrimary,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: myColorScheme.onSecondaryContainer,
        ),
      ),
);

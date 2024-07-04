import 'package:flutter/material.dart';

final myDarkColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 96, 179));

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: myDarkColorScheme,

  // The app bar theme is used to specify the appearance of the app bar
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(200, 46, 48, 57),
    foregroundColor: const Color.fromARGB(255, 255, 255, 255),

    // The titleTextStyle is used to specify the appearance of the title of the app bar
    titleTextStyle: TextStyle(
      color: myDarkColorScheme.onPrimary,
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),

    // The iconTheme is used to specify the color of the icons in the app bar
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
  ),

  // The scaffoldBackgroundColor is used to specify the background color of the scaffold
  scaffoldBackgroundColor: const Color.fromARGB(200, 46, 48, 57),

  // The cardTheme is used to specify the appearance of the cards in the app
  cardTheme: const CardTheme(
    color: Color.fromARGB(255, 73, 76, 103),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),

  // The elevatedButtonTheme is used to specify the appearance of the elevated buttons in the app
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: myDarkColorScheme.primaryContainer,
    ),
  ),

  // The bottomSheetTheme is used to specify the appearance of the bottom sheet in the app
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromARGB(255, 46, 48, 57),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white54),
    labelStyle: TextStyle(color: Colors.white),
  ),

  // The dialogTheme is used to specify the appearance of the dialog in the app
  dialogTheme: const DialogTheme(
    backgroundColor: Color.fromARGB(255, 46, 48, 57),
  ),

// the date picker theme is used to specify the appearance of the date picker in the app
  datePickerTheme: DatePickerThemeData(
    backgroundColor: myDarkColorScheme.primaryContainer,
    shadowColor: myDarkColorScheme.secondaryContainer,
    headerHelpStyle: TextStyle(
      color: myDarkColorScheme.onSecondaryContainer,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white54),
      labelStyle: TextStyle(color: Colors.white),
    ),
  ),

  // The textTheme is used to specify the appearance of the text in the app
  textTheme: ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: myDarkColorScheme.secondaryContainer,
        ),
      ),
);

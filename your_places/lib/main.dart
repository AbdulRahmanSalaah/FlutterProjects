import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import the 'riverpod' package
import 'package:google_fonts/google_fonts.dart';

import 'screens/places_screen.dart';

final ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 99, 8, 246),
  // background: const Color.fromARGB(255, 57, 47, 68),
  brightness: Brightness.dark,
);

void main() {

  // Wrap the 'MyApp' widget with the 'ProviderScope' widget to provide the 'riverpod' package
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(206, 57, 47, 68),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 57, 47, 68),
        ),
        textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
          titleSmall: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.ubuntuCondensed(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const PlacesScreen(),
    );
  }
}

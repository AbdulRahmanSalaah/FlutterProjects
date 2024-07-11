import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/tabs_screen.dart';

void main() {
  // Wrap the MyApp widget with the ProviderScope widget.
  // The ProviderScope widget is used to provide the providers to the widget tree.
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.red,
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const TabsScreen(),
    );
  }
}

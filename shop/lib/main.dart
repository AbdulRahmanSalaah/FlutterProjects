import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/grocery_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        // primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 146, 230, 247),
          surface: const Color.fromARGB(255, 44, 50, 60),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 49, 57, 59),
      ),
      home: const GroceryList(),
    );
  }
}

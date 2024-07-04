import 'package:expenses_manager/app_themes/dark.dart';
import 'package:expenses_manager/app_themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/expanses.dart';

void main() {
  //  The WidgetsFlutterBinding.ensureInitialized() method is used to ensure that the Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // The SystemChrome.setPreferredOrientations() method is used to set the preferred orientations of the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // portrait mode
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
      themeMode: ThemeMode.system,
      theme: lightTheme,
      // The darkTheme is used to specify the dark theme of the app
      darkTheme: darkTheme,
      home: const Expanses(),
    );
  }
}

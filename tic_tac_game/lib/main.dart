import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model/history_hive_model.dart';
import 'screens/main_menu.dart';
import 'storage/history_box.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryModelHiveAdapter());
  await HistoryBox.openBox();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: "PermanentMarker",
        useMaterial3: true,
        textTheme: GoogleFonts.peraltaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MainMenu(),
    );
  }
}

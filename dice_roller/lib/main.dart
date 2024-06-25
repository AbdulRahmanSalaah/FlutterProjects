import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

import 'gradient_container.dart';

void main() {
  runApp(
   const MaterialApp(
      home: Scaffold( // Scaffold is a container that provides a default app bar, title, and a body property that holds the main content of the app.
          // backgroundColor: Colors.blueGrey,
          body:  GradientContainer(),

          ),
    ), 
  );
}



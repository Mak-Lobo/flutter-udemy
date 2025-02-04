import 'package:flutter/material.dart';
import 'package:go_moon_stateless/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoMoon',
      // defining common attributes/ appearance of the app
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 0),
      ),
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frivia/pages/gameView.dart';
import 'package:frivia/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        fontFamily: 'HennyPenny',
        fontFamilyFallback: const ['Roboto', 'Arial'],
        scaffoldBackgroundColor: Colors.lightBlue
      ),
      home: HomeView(),
    );
  }


}

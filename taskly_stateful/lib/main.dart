import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly_stateful/pages/home.dart';

void main() async {
  await Hive.initFlutter('taskly');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

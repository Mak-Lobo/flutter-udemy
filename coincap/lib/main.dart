import 'dart:convert';

import 'package:coincap/model/app%20config.dart';
import 'package:coincap/pages/home.dart';
import 'package:coincap/service/web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerService();
  runApp(const MainApp());
}

Future<void> loadConfig() async {
  String _config = await rootBundle.loadString('assets/configuration/main.json');

  Map _configMap = jsonDecode(_config);
  // print(_configMap);

  GetIt.I.registerSingleton<Appconfig>(
    Appconfig(baseURL: _configMap["COIN_API_BASE_URL"]),
  );
}

void registerService() {
  GetIt.I.registerSingleton<WebService>(WebService());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinCap Crypto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
          surface: const Color.fromARGB(255, 63, 43, 177),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(192, 54, 8, 160),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

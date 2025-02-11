import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GameProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _amount = 15;
  int questionCount = 0;
  int correctChoices = 0;
  String? _baseUrl;
  final String difficulty;
  List? triviaQuestions;
  BuildContext? context;

  GameProvider({required this.context, required this.difficulty}) {
    _baseUrl = 'https://opentdb.com/api.php';
    fetchQuestions();
    print(_baseUrl);
  }

  // String? get url => _url;

  // void setUrl(String url) {
  //   _url = url;
  //   notifyListeners();
  // }

  Future<void> fetchQuestions() async {
    try {
      final response = await _dio.get(
        _baseUrl!,
        queryParameters: {
          'amount': _amount,
          'difficulty': difficulty,
          'type': 'boolean',
        },
      ); // setting query parameters
      var data = jsonDecode(response.toString());
      print(data);

      triviaQuestions = data['results'];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // question text
  String getQuestion() {
    return "${questionCount + 1}. ${triviaQuestions![questionCount]['question']}";
  }

  void answer(String answer) async {
    bool correctAnswer =
        triviaQuestions![questionCount]['correct_answer'] == answer;

    questionCount++;
    if (correctAnswer == true) {
      correctChoices++;
    }
    // print(correctAnswer ? 'Correct Answer' : 'Wrong Answer');
    showDialog(
        context: context!,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(correctAnswer ? 'Correct Answer' : 'Wrong Answer'),
            backgroundColor:
                correctAnswer ? Colors.green[800] : Colors.red[800],
            icon: correctAnswer
                ? const Icon(Icons.check)
                : const Icon(Icons.cancel_rounded),
            iconColor: Colors.white,
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    if (questionCount == _amount) {
      finishGame();
    } else {
      Navigator.of(context!).pop();
      notifyListeners();
    }
  }

  // finishing the game
  Future<void> finishGame() async {
    showDialog(
        context: context!,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Colors.lightBlue[800],
            title: const Text('Game Over'),
            content: Text('You have answered $questionCount questions, $correctChoices which are correct.'),
          );
        });
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context!).pop();
    Navigator.of(context!).pop();
    Navigator.of(context!).pop();
    questionCount = 0;
    notifyListeners();
  }
}

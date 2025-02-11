import 'package:flutter/material.dart';
import 'package:frivia/provider/urlProvider.dart';
import 'package:provider/provider.dart';

class Gameview extends StatelessWidget {
  double? width, height;
  GameProvider? urlProvider;
  final String diffLevel;

  Gameview({required this.diffLevel});


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_homeContext) => GameProvider(
        context: _homeContext,
        difficulty: diffLevel
      ),
      child: gameUi(),
    );
  }

  // the widget used for the game ui
  Widget gameUi() {
    return Builder(builder: (context) {
      urlProvider = context.watch<GameProvider>();
      if (urlProvider!.triviaQuestions == null) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      } else {
        return SafeArea(
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width! * 0.1,
                vertical: height! * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  quizText(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      trueOpt(),
                      SizedBox(height: width! * 0.05),
                      falseOpt(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  // question widgets
  Widget quizText() {
    return Text(
      urlProvider!.getQuestion(),
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // button widgets
  Widget trueOpt() {
    return MaterialButton(
      onPressed: () {
        urlProvider!.answer('True');
      },
      color: Colors.green,
      textColor: Colors.white,
      minWidth: width! * 0.75,
      height: height! * 0.125,
      child: const Text(
        'True',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget falseOpt() {
    return MaterialButton(
      onPressed: () {
        urlProvider!.answer('False');
      },
      color: Colors.red,
      textColor: Colors.white,
      minWidth: width! * 0.75,
      height: height! * 0.125,
      child: const Text(
        'False',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

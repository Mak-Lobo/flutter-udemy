import 'package:flutter/material.dart';
import 'package:frivia/pages/gameView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late double width, height;
  double difficultyLevel = 0;
  final List<String> difficulty = ['Easy', 'Medium', 'Hard'];
  
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.1,
          vertical: height * 0.05,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.1,
          vertical: height * 0.05,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Frivia",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      difficulty[difficultyLevel.toInt()],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              ),
              slider(),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => Gameview(
                          diffLevel: difficulty[difficultyLevel.toInt()].toLowerCase(),
                        ),
                      )
                  );
                },
                color: Colors.blue[800],
                minWidth: width * 0.75,
                height: height * 0.1,
                child: const Text(
                  "Start Game",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // slider widget
  Widget slider() {
    return Slider(
      value: difficultyLevel,
      onChanged: (value) {
        setState(() {
          difficultyLevel = value;
        });
      },
      min: 0,
      max: 2,
      divisions: 2,
      activeColor: Colors.blue[800],
      inactiveColor: Colors.blueGrey[400],
    );
  }
}

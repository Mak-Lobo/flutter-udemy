import 'dart:developer' as devp;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi_cupertino/custom_widgets/custom_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../calculate.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double? width, height;
  int age = 20, weight = 100, heightInInches = 60, gender = 0;
  double bmi = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomCard(
                width: width! * 0.45,
                height: height! * 0.225,
                child: ageSelection(),
              ),
              CustomCard(
                width: width! * 0.45,
                height: height! * 0.225,
                child: weightSelection(),
              ),
            ],
          ),
          heightSelection(),
          genderSelection(),
          bmiButton(),
        ],
      ),
    );
  }

  // age selection
  Widget ageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Age',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          age.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    age--;
                  });
                },
                child: const Icon(
                  CupertinoIcons.minus,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 40,
              child: CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    age++;
                  });
                },
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // weight selection
  Widget weightSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Weight in Pounds (lbs)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          weight.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: CupertinoDialogAction(
                key: const Key('remove weight'),
                onPressed: () {
                  setState(() {
                    weight--;
                  });
                },
                child: const Icon(
                  CupertinoIcons.minus,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 40,
              child: CupertinoDialogAction(
                key: const Key('add weight'),
                onPressed: () {
                  setState(() {
                    weight++;
                  });
                },
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // height slider selection
  Widget heightSelection() {
    return Container(
      height: height! * 0.18,
      width: width! * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Height in Inches',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            heightInInches.toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: width! * 0.8,
            child: CupertinoSlider(
              value: heightInInches.toDouble(),
              min: 24,
              max: 96,
              onChanged: (double value) {
                setState(() {
                  heightInInches = value.toInt();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // gender selection
  Widget genderSelection() {
    return CustomCard(
      width: width! * 0.8,
      height: height! * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: gender,
            children: const {
              0: Text('Male'),
              1: Text('Female'),
            },
            onValueChanged: (int? value) {
              setState(() {
                gender = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  // BMI button
  Widget bmiButton() {
    return SizedBox(
      width: width! * 0.8,
      height: height! * 0.1,
      child: CupertinoButton.filled(
        child: const Text(
          'Calculate BMI',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          setState(() {
            bmi = calculateBMI(weight, heightInInches);
            print(bmi);
            bmiResult();
          });
        },
      ),
    );
  }

  // BMI result
  void bmiResult() {
    String? status;
    if (bmi < 18.5) {
      status = 'Underweight';
    } else if (bmi < 25) {
      status = 'Normal';
    } else if (bmi < 30) {
      status = 'Overweight';
    } else {
      status = 'Obese';
    }

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('BMI: ${bmi.toStringAsFixed(2)}'),
          content: Text('Status: $status'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Close'),
              onPressed: () {
                bmiHistory(bmi.toStringAsFixed(2), status!);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

// BMI history
  void bmiHistory(String bmiValue, String statusValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bmi_date', DateTime.now().toString());
    await prefs.setStringList('bmi_data', [bmiValue, statusValue]);

    // print('BMI values saved');
    devp.log('\u001B[36mResults saved!\u001B[0m');
    /*
    \u001B[0m Reset
    \u001B[30m Black
    \u001B[31m Red
    \u001B[32m Green
    \u001B[33m Yellow
    \u001B[34m Blue
    \u001B[35m Magenta
    \u001B[36m Cyan
    \u001B[37m White
    \u001B[40m Black Background
    \u001B[41m Red Background
    \u001B[42m Green Background
    \u001B[43m Yellow Background
    \u001B[44m Blue Background
    \u001B[45m Magenta Background
    \u001B[46m Cyan Background
    \u001B[47m White Background
    */
  }
}

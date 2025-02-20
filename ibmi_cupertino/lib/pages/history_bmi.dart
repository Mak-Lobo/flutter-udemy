import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi_cupertino/custom_widgets/custom_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  double? width, height;

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    SharedPreferences.getInstance();

    return CupertinoPageScaffold(
      child: Center(
        child: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final prefs = snapshot.data! as SharedPreferences;
                final bmiDate = prefs.getString('bmi_date');
                DateTime parsedDate = DateTime.parse(bmiDate!);
                final bmiData = prefs.getStringList('bmi_data');
                return CustomCard(
                  width: width! * 0.635,
                  height: height! * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        bmiData![1],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        bmiData[0],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.blue,
                ),
              );
            }),
      ),
    );
  }
}

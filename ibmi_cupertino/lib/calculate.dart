import 'dart:math';

import 'package:dio/dio.dart';

double calculateBMI(int weight, int height) {
  return weight / pow(height, 2) * 703;
}

// dependency mocktail
Future<double> calculateBMIAsync(Dio _dio) async {
  var _response = await _dio.get('https://jsonkeeper.com/b/AKFA');
  var data = _response.data;
  var bmi = calculateBMI(
    data['Sergio Ramos'][0],
    data['Sergio Ramos'][1],
  );

  return bmi;
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi_cupertino/calculate.dart';
import 'package:mocktail/mocktail.dart';

// dependency mocking using Mocktail
class MockDio extends Mock implements Dio {}

void main() {
  test('Given height and weight, calculate BMI and return result.', () {
    // Arrange -> set up the test
    const int weight = 110, height = 71;
    // Act -> perform the action
    double bmi = calculateBMI(weight, height);
    // Assert -> check the result
    expect(bmi, 15.34021027573894);
  });

  test('Given a URL, fetch data and calculate the BMI', () async {
    // Arrange
    final mockDio = MockDio();
    when(() => mockDio.get('https://www.jsonkeeper.com/b/AKFA')).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: 'https://www.jsonkeeper.com/b/AKFA'),
      data: jsonEncode({"Sergio Ramos": [72, 165]}),
    ));

    // Act
    var bmi = await calculateBMIAsync(mockDio);

    // Assert
    expect(bmi, 22.3755);
  });
}
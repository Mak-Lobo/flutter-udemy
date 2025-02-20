import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi_cupertino/pages/bmi.dart';

void main() {
  // widget testing
  testWidgets('When the BMI button is tapped, increment the count by 1 ...',
      (tester) async{
    // Arrange
    await tester.pumpWidget(const CupertinoApp(
      home: BMIPage(),
    ));
    var _incrementBTN = find.byKey(const Key('add weight'));
    // Act
    await tester.tap(_incrementBTN);
    await tester.pump();
    // Assert
    var _weight = find.text('20');
    expect(_weight, findsOneWidget);
  });
}

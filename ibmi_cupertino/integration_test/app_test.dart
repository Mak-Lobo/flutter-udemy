import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ibmi_cupertino/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    // tested widgets
    var _incrementweightBTN = find.byKey(const Key('add weight'));
    var _decrementweightBTN = find.byKey(const Key('remove weight'));
    var _bmiBTN = find.byType(CupertinoButton);

    // widget testing
    testWidgets(
        'Given weight and height are given, and button is pressed, calculate BMI',
        (tester) async {
          // Arrange
          app.main();
          // Act
          await tester.pumpAndSettle();
          await tester.tap(_incrementweightBTN);
          await tester.tap(_bmiBTN);
          await tester.pumpAndSettle();
          await tester.tap(_decrementweightBTN);
          await tester.pumpAndSettle();

          final _result = find.text('20');

          // Assert
          expect(_result, findsOneWidget);
        });
  });
}

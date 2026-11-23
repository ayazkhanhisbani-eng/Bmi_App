import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/main.dart';
import 'package:bmi_calculator/ui/screens/calculator_screen.dart';
import 'package:bmi_calculator/ui/screens/result_screen.dart';
import 'package:bmi_calculator/models/bmi_data.dart';

void main() {
  testWidgets('App renders Splash screen initially', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const BmiCalculatorApp());

    // Splash contains brand elements
    expect(find.text('CALCULATOR'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump past splash timer
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();

    // Now on CalculatorScreen
    expect(find.text('BMI Calculator'), findsOneWidget);
  });

  testWidgets('CalculatorScreen displays all design elements and buttons', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: CalculatorScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Check title and gender
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);

    // Check cards
    expect(find.text('Weight'), findsOneWidget);
    expect(find.text('Height'), findsOneWidget);
    expect(find.text('Age'), findsOneWidget);

    // Check default values from reference
    expect(find.text('200'), findsOneWidget);
    expect(find.text('170'), findsOneWidget);
    expect(find.text('26'), findsOneWidget);

    // Check unit buttons
    expect(find.text('LB'), findsOneWidget);
    expect(find.text('KG'), findsOneWidget);
    expect(find.text('CM'), findsAtLeastNWidgets(1));
    expect(find.text('FT'), findsOneWidget);

    // Check calculate button
    expect(find.text('Calculate'), findsOneWidget);

    // Tap Female to select Female
    await tester.tap(find.text('Female'));
    await tester.pumpAndSettle();

    // Tap Calculate to navigate to ResultScreen
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();

    // Verify ResultScreen elements
    expect(find.text('Our Recommendations'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(find.text('200 LB'), findsOneWidget);
    expect(find.text('170 CM'), findsOneWidget);
    expect(find.text('26 Years'), findsOneWidget);

    // Tap Retry to go back
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    // Back on CalculatorScreen
    expect(find.text('BMI Calculator'), findsOneWidget);
  });

  testWidgets('ResultScreen displays gauge and recommendations', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);

    const testResult = BmiCalculationResult(
      bmi: 23.9,
      gender: Gender.male,
      displayWeight: 200,
      weightUnit: WeightUnit.lb,
      displayHeight: 170,
      heightUnit: HeightUnit.cm,
      age: 26,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: ResultScreen(result: testResult),
      ),
    );
    await tester.pumpAndSettle();

    // Verify 23.9 and Normal are shown
    expect(find.text('23.9'), findsOneWidget);
    expect(find.text('Normal'), findsAtLeastNWidgets(1));

    // Verify Legend categories
    expect(find.text('Underweight'), findsOneWidget);
    expect(find.text('Overweight'), findsOneWidget);
    expect(find.text('Obese class I'), findsOneWidget);
    expect(find.text('Obese class II'), findsOneWidget);

    // Verify Recommendations header
    expect(find.text('Our Recommendations'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}

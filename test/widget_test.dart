import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('WeatherHomeScreen renders title, text input, and search button', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());

    // Verify title and input elements exist
    expect(find.text('Weather Search'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Search'), findsOneWidget);

    // Enter a city name in the text field
    await tester.enterText(find.byType(TextField), 'Pretoria');
    expect(find.text('Pretoria'), findsOneWidget);
  });
}
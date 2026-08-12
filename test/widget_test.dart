// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/main.dart';

void main() {
  testWidgets('user can search for a city', (WidgetTester tester) async {
    // Open the weather app.
    await tester.pumpWidget(const MaterialApp(
      home: WeatherHomePage(),
    ));

    // Find the city input field.
    final cityField = find.byType(TextField);

    // Type a city into the field.
    await tester.enterText(cityField, 'Cape Town');

    // Press the Search button.
    await tester.tap(find.text('Search'));

    // Rebuild the screen after the button press.
    await tester.pump();

    // Check that the searched city appears on the screen.
   await tester.pump();

  expect(find.text('Cape Town'), findsNWidgets(2));
  });
}
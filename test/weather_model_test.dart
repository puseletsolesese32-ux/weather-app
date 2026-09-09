import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  group('Weather Model Test', () {
    test('Weather.fromJson correctly parses OpenWeatherMap JSON payload', () {
      final sampleJson = {
        'name': 'Johannesburg',
        'main': {'temp': 22.5},
        'weather': [
          {'description': 'clear sky', 'icon': '01d'}
        ]
      };

      final weather = Weather.fromJson(sampleJson);

      expect(weather.cityName, 'Johannesburg');
      expect(weather.temperature, 22.5);
      expect(weather.description, 'clear sky');
      expect(weather.icon, '01d');
    });
  });
}
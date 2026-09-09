import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey;
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  WeatherService({required this.apiKey});

  /// Fetches weather data for a given city name
  Future<Weather> fetchWeather(String cityName) async {
    final uri = Uri.parse('$baseUrl?q=${Uri.encodeComponent(cityName)}&appid=$apiKey&units=metric');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('City not found. Please check the spelling.');
    } else {
      throw Exception('Failed to load weather data. (Status Code: ${response.statusCode})');
    }
  }
}
import 'package:flutter/material.dart';
import 'models/weather_model.dart';
import 'services/weather_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherHomeScreen(),
    );
  }
}

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
 
final WeatherService _weatherService = WeatherService(
  apiKey: dotenv.env['OPENWEATHER_API_KEY'] ?? '',
);

  final TextEditingController _cityController = TextEditingController();

  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  void _getWeather() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _weather = null;
    });

    try {
      final weather = await _weatherService.fetchWeather(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Search'),
        centerTitle: true,
      ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF1A1B4B),
        Color(0xFF2E3278),
        Color(0xFF4A52A8),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
          children: [
            // Search Input Row
           Card(
  elevation: 6,
  shadowColor: Colors.black38,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
    child: Row(
      children: [
        const Icon(Icons.search, color: Color(0xFF4A52A8)),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: _cityController,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              hintText: 'Enter city name...',
              hintStyle: TextStyle(color: Colors.black38),
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _getWeather(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          color: const Color(0xFF4A52A8),
          onPressed: _isLoading ? null : _getWeather,
        ),
      ],
    ),
  ),
),
            const SizedBox(height: 30),
            

         // Dynamic UI Content Based on State
            if (_isLoading) ...[
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ] else if (_errorMessage != null) ...[
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white30),
                ),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else if (_weather != null) ...[
              Card(
                elevation: 12,
                shadowColor: Colors.black54,
                color: Colors.white.withOpacity(0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: const BorderSide(color: Colors.white24, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    children: [
                      // City Name
                      Text(
                        _weather!.cityName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Live Weather Icon from OpenWeatherMap API
                      Image.network(
                        'https://openweathermap.org/img/wn/${_weather!.iconCode}.png',
                        height: 110,
                        width: 110,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.wb_sunny_rounded, size: 80, color: Colors.amber),
                      ),
                      // Temperature Display
                      Text(
                        '${_weather!.temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      // Weather Description
                      Text(
                        _weather!.description.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                       const SizedBox(height: 24),
                       const Divider(color: Colors.white24, thickness: 1),
                       const SizedBox(height: 16),

                      //  Additional Metrics Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Humidity Metric
                          Column(
                            children: [
                              const Icon(Icons.water_drop_outlined, color: Colors.lightBlueAccent, size: 28),
                              const SizedBox(height: 6),
                              Text(
                                '${_weather!.humidity}%',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Humidity',
                                style: TextStyle(fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),
                          // Wind Speed Metric
                          Column(
                            children: [
                              const Icon(Icons.air_rounded, color: Colors.lightGreenAccent, size: 28),
                              const SizedBox(height: 6),
                              Text(
                                '${_weather!.windSpeed.toStringAsFixed(1)} m/s',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'Wind Speed',
                                style: TextStyle(fontSize: 12, color: Colors.white60),
                              ),
                            ],
                          ),

                    ],
                  ),
                ],
              ),
            ),
          ),
            ] else ...[
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Enter a city name above to search for current weather.',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
      ),
    );
  }
}
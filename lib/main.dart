import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: WeatherHomePage()));
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController cityController = TextEditingController();
  String searchedCity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Weather App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Search for a city'),

            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                hintText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
            onPressed: () {
              setState(() {
                searchedCity = cityController.text;
              });
            },
              child: const Text('Search'),
            ),
            Text(searchedCity),
          ],
        ),
      ),
    );
  }
}
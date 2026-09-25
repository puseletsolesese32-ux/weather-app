# Weather App

A modern, responsive Flutter weather application that allows users to search for any city globally and view current weather conditions with detailed environmental metrics.

## Purpose

The purpose of this project is to learn and demonstrate mobile application development using Flutter and Dart while building a practical, well-architected weather application.

## Features

- **Global City Search:** Look up real-time weather conditions for cities worldwide.
- **Dynamic Weather Dashboard:** Displays temperature in Celsius, city name, condition description, and live weather icons fetched from the OpenWeatherMap API.
- **Detailed Environmental Metrics:** Displays humidity percentage and wind speed (m/s).
- **Glassmorphic UI Design:** Features a midnight-purple linear gradient background with elevated frosted-glass result cards.
- **State & Error Handling:** Manages loading spinners, network errors, and invalid city lookup states smoothly.
- **Secure API Key Management:** Utilizes `flutter_dotenv` and `--dart-define` build flags to prevent API key exposure in version control.
- **Automated Testing:** Includes unit and widget test coverage for state changes and data parsing.

## Technologies Used

- **Framework:** Flutter
- **Language:** Dart
- **API Provider:** OpenWeatherMap API
- **Environment & Security:** `flutter_dotenv`
- **Version Control:** Git & GitHub
- **Testing:** Flutter Test Package

## Project Structure

```text
lib/
├── main.dart                   # Application entry point & WeatherHomeScreen widget
├── models/
│   └── weather_model.dart      # Weather data model & JSON deserialization
├── services/
│   └── weather_service.dart    # HTTP networking service for OpenWeatherMap API
└── widgets/                    # Reusable UI components

test/
└── widget_test.dart            # Automated widget & unit testing suite

## Getting Started
​Prerequisites
​Flutter SDK installed
​OpenWeatherMap API Key

​Installation & Setup
1. clone the repository.
git clone [https://github.com/puseletsolesese32-ux/weather_app.git](https://github.com/puseletsolesese32-ux/weather_app.git)
cd weather_app

2. Install dependencies:
flutter pub get

3. Configure Environment Variables:
Create a .env file in the root directory and add your key:
OPENWEATHER_API_KEY=your_openweather_api_key_here

4. Run the Application:
Run the app securely with --dart-define:
flutter run -d chrome --dart-define=OPENWEATHER_API_KEY=your_openweather_api_key_here

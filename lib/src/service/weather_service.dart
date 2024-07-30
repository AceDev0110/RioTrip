import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final double latitude = -22.908333;
  final double longitude = -43.196388;

  Future<Map<String, dynamic>> fetchWeather() async {
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final weatherData = data['current_weather'];
      final temperature = weatherData['temperature'];
      final weatherCode = weatherData['weathercode'];
      final time = weatherData['time'];
      final isDay = weatherData['is_day'] == 1;

      return {
        'temperature': temperature,
        'weatherCode': weatherCode,
        'time': time,
        'isDay': isDay,
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Method to map weather code to description
  String mapWeatherCodeToDescription(int code) {
    // This is a simplified example, you may need a more comprehensive mapping
    switch (code) {
      case 0:
        return 'clear';
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return 'cloud';
      case 51:
      case 53:
      case 55:
        return 'freezing'; // drizzle
      case 61:
      case 63:
      case 65:
        return 'rain';
      case 66:
      case 67:
        return 'freezing'; // Freezing rain
      case 71:
      case 73:
      case 75:
        return 'freezing'; // Snowfall
      case 77:
        return 'freezing'; // Snow grains
      case 80:
      case 81:
      case 82:
        return 'rain'; // Rain showers
      case 85:
      case 86:
        return 'rain'; // Snow showers
      case 95:
        return 'rain'; // Thunderstorm
      default:
        return 'cloud'; // Unknown weather
    }
  }
}

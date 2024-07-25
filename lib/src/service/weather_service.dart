import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'YOUR_OPENWEATHER_API_KEY'; // replace with your OpenWeather API key

  Future<String> fetchWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final weatherDescription = data['weather'][0]['description'];
      final temperature = data['main']['temp'];
      return '$weatherDescription, ${temperature}°C';
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

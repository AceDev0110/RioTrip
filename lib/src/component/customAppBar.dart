import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import '../service/weather_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchWeather() {
    return WeatherService().fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF012147), // Set the background color
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: fetchWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 16, // Adjust height as needed for alignment
                  width: 16,
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('Failed to load',
                    style: TextStyle(fontSize: 14, color: Colors.white));
              } else {
                final data = snapshot.data;
                final temperature = data?['temperature'];
                final weatherCode = data?['weatherCode'];
                final time = data?['time'];
                final isDay = data?['isDay'];
                final weatherDescription =
                    WeatherService().mapWeatherCodeToDescription(weatherCode);

                final formattedTime =
                    DateFormat.jm().format(DateTime.parse(time));
                final formattedDate =
                    DateFormat.MMMMEEEEd().format(DateTime.parse(time));
                final dayOrNight = isDay ? 'day' : 'night';

                final iconPath =
                    'assets/weather/${dayOrNight}_${weatherDescription}.png';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Weather Icon
                        Image.asset(
                          iconPath,
                          height: 24,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(width: 8),
                        // Temperature
                        Text(
                          '$temperature°C',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    // Date Time
                    Text(
                      '$formattedDate, $formattedTime',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                );
              }
            },
          ),
          Image.asset(
            'assets/images/appbartitle.png',
            height: 40, // Adjust the height as needed
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

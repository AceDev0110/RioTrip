import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../service/weather_service.dart';

class BookstoreScaffold extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const BookstoreScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  _BookstoreScaffoldState createState() => _BookstoreScaffoldState();
}

class _BookstoreScaffoldState extends State<BookstoreScaffold> {
  late Future<String> weatherFuture;
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    weatherFuture = weatherService.fetchWeather('Rio de Janeiro');
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF012147), // Set the background color
        // Use a Row to position weather info on the left and image at the right
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<String>(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 24, // Adjust height as needed for alignment
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: '+31\'',
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                            text: ' June 5, 12:00',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                } else {
                  return Text(
                    snapshot.data ?? 'Failed to load',
                    style: TextStyle(fontSize: 14),
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
      ),
      body: AdaptiveNavigationScaffold(
        selectedIndex: widget.selectedIndex,
        body: widget.child,
        onDestinationSelected: (idx) {
          if (idx == 0) goRouter.go('/attractions/map');
          if (idx == 1) goRouter.go('/alphabet');
          if (idx == 2) goRouter.go('/phrasebook');
          if (idx == 3) goRouter.go('/converter');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Attractions',
            icon: Icons.attractions,
          ),
          AdaptiveScaffoldDestination(
            title: 'Alphabet',
            icon: Icons.sort_by_alpha,
          ),
          AdaptiveScaffoldDestination(
            title: 'Phrasebook',
            icon: Icons.book,
          ),
          AdaptiveScaffoldDestination(
            title: 'Converter',
            icon: Icons.currency_bitcoin,
          ),
        ],
      ),
    );
  }
}

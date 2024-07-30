import 'package:RioTrip/src/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../component/attractionbuttons.dart';
import '../../component/placeinfo.dart';
import '../../data/places.dart'; // Import the places data

class AttractionsListScreen extends StatelessWidget {
  final String title;

  const AttractionsListScreen({
    this.title = 'Attractions',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return PlaceInfo(
                imgName: place['imgName']!,
                subject: place['subject']!,
                description: place['description']!,
                location: place['location']!,
              );
            },
          ),
          const AttractionButtons(),
        ],
      ),
    );
  }
}

import 'package:RioTrip/src/data/areapositions.dart';
import 'package:RioTrip/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:RioTrip/src/component/attractionbuttons.dart';
import 'package:RioTrip/src/component/placeinfo.dart';
import 'package:RioTrip/src/data/places.dart';

class AttractionsMapScreen extends StatefulWidget {
  final String title;

  const AttractionsMapScreen({
    this.title = 'Attractions',
    super.key,
  });

  @override
  _AttractionsMapScreenState createState() => _AttractionsMapScreenState();
}

class _AttractionsMapScreenState extends State<AttractionsMapScreen> {
  // Track the selected button
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1200.0;
    final screenHeight = 670.0;
    final buttonSize = 42.0;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(0.0),
                      minScale: 1,
                      maxScale: 3.0,
                      child: Container(
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/map.png',
                              width: screenWidth,
                              height: screenHeight,
                              // height: screenHeight -
                              //     kToolbarHeight -
                              //     MediaQuery.of(context).padding.top,
                              fit: BoxFit.cover,
                            ),
                            // Positions of the buttons on the map
                            for (int i = 0; i < areaPositions.length; i++)
                              Positioned(
                                left: screenWidth * areaPositions[i]['x']! - buttonSize / 2,
                                top: (screenHeight -
                                        // kToolbarHeight -
                                        MediaQuery.of(context).padding.top) *
                                    areaPositions[i]['y']! - buttonSize / 2,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = i;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        8), // Equal width and height
                                    width: buttonSize,
                                    height: buttonSize,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.2), // Shadow color with opacity
                                          spreadRadius: 2, // Spread radius
                                          blurRadius: 5, // Blur radius
                                          offset: Offset(0,
                                              3), // Offset in the x and y direction, e.g., (0, 3) for a shadow below the box
                                        ),
                                      ],
                                      color: selectedIndex == i
                                          ? positionButtonColor2
                                          : positionButtonColor1,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${i + 1}', // Index number on the button
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          if (selectedIndex != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 80, // Positioned at the bottom of the screen
              child: Stack(
                children: [
                  PlaceInfo(
                    imgName: places[selectedIndex!]['imgName']!,
                    subject: places[selectedIndex!]['subject']!,
                    description: places[selectedIndex!]['description']!,
                    location: places[selectedIndex!]['location']!,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    width: 30,
                    height: 30,
                    child: Container(
                      color: Colors.white, // White box
                      child: IconButton(
                        icon: Icon(Icons.close,
                            size: 15, color: Colors.green), // Green close icon
                        onPressed: () {
                          setState(() {
                            selectedIndex = null; // Close the detail view
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const AttractionButtons(),
        ],
      ),
    );
  }
}

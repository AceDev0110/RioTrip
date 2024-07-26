import 'package:flutter/material.dart';
import '../../component/attractionbuttons.dart';
class AttractionsMapScreen extends StatelessWidget {
  final String title;
  const AttractionsMapScreen({
    this.title = 'Attractions',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                    child: Image.asset(
                      'assets/images/map.png',
                      height: screenHeight - kToolbarHeight - MediaQuery.of(context).padding.top,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const AttractionButtons(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../component/attractionbuttons.dart';
class AttractionsListScreen extends StatelessWidget {
  final String title;
  const AttractionsListScreen({
    this.title = 'Attractions',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const AttractionButtons(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/colors.dart'; // Import the colors

class AlphabetInfo extends StatelessWidget {
  final String alphabet;
  final String pronounce;
  final String description;

  const AlphabetInfo({
    required this.alphabet,
    required this.pronounce,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: alphabetBackgroundColor, // Set the background color
      padding: const EdgeInsets.all(30.0),
      height: 160,
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                alphabet,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: titleColor, // Use titleColor
                ),
              ),
              const SizedBox(width: 30),
              Text(
                pronounce,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: pronaunceColor, // Use descriptionColor
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: descriptionColor, // Use locationColor
            ),
          ),
        ],
      ),
    );
  }
}

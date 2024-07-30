import 'package:flutter/material.dart';
import '../theme/colors.dart'; // Import the colors

class PlaceInfo extends StatelessWidget {
  final String imgName;
  final String subject;
  final String description;
  final String location;

  const PlaceInfo({
    required this.imgName,
    required this.subject,
    required this.description,
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: placeBackgroundColor, // Set the background color here
      margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imgName,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: titleColor, // Use titleColor
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: descriptionColor, // Use descriptionColor
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: locationColor, // Use locationColor
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

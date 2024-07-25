// alphabet_screen.dart

import 'package:RioTrip/src/theme/colors.dart';
import 'package:flutter/material.dart';
import '../component/alphabetinfo.dart'; // Import the AlphabetInfo component
import '../data/alphabets.dart';

class AlphabetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 20), 
          itemCount: alphabetInfoData.length,
          itemBuilder: (context, index) {
            final item = alphabetInfoData[index];
            return AlphabetInfo(
              alphabet: item['alphabet']!,
              pronounce: item['pronounce']!,
              description: item['description']!,
            );
          },
        ),
      );
}

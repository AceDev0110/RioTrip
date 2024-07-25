import 'package:RioTrip/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../data/phrasedata.dart';

class PhrasebookScreen extends StatelessWidget {
  const PhrasebookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String? selectedPhrase =
                phraseData.isNotEmpty ? phraseData[0]['phrase'] : null;
            String content =
                phraseData.isNotEmpty ? phraseData[0]['content']! : '';

            return StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color:
                            phraseSelectionColor, // Collapsed background color
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor:
                              primaryColor, // Dropdown background color
                          value: selectedPhrase,
                          isExpanded: true,
                          hint: const Text(
                            'Select a phrase',
                            style: TextStyle(color: titleColor),
                          ),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: titleColor), // Dropdown text color
                          items: phraseData.map<DropdownMenuItem<String>>(
                              (Map<String, String> item) {
                            return DropdownMenuItem<String>(
                              value: item['phrase'],
                              child: Container(
                                alignment: Alignment
                                    .centerLeft, // Align text vertically center
                                child: Text(
                                  item['phrase']!,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          descriptionColor), // Regular item text color
                                ),
                              ),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) {
                            return phraseData
                                .map<Widget>((Map<String, String> item) {
                              return Container(
                                alignment: Alignment
                                    .centerLeft, // Align text vertically center
                                child: Text(
                                  item['phrase']!,
                                  style: const TextStyle(
                                    color:
                                        descriptionColor, // Selected item text color
                                    fontWeight: FontWeight
                                        .bold, // Selected item text bold
                                  ),
                                ),
                                color:
                                    phraseSelectionColor, // Selected item background color
                              );
                            }).toList();
                          },
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPhrase = newValue;
                              content = phraseData.firstWhere((element) =>
                                  element['phrase'] == newValue)['content']!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Html(
                          data: content,
                          style: {
                            'body': Style(fontSize: FontSize(16)),
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

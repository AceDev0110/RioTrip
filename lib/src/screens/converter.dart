import 'dart:convert';
import 'package:RioTrip/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ConverterScreen extends StatelessWidget {
  ConverterScreen({Key? key}) : super(key: key);

  final TextEditingController amountController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  final currencies = ['USD', 'EUR', 'BRL', 'GBP', 'CNY'];
  String fromCurrency = 'USD';
  String toCurrency = 'BRL';

  // Function to fetch exchange rates
  Future<Map<String, double>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(
        'https://v6.exchangerate-api.com/v6/e610c07778c4316887cca017/latest/USD'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rates = data['conversion_rates'] as Map<String, dynamic>;
      return rates
          .map((key, value) => MapEntry(key, (value as num).toDouble()));
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  // Function to convert currency
  void convertCurrency(Map<String, double> rates) {
    if (amountController.text.isEmpty) return;

    final amount = double.parse(amountController.text);
    final rate = rates[toCurrency]! / rates[fromCurrency]!;
    final convertedAmount = amount * rate;
    resultController.text = convertedAmount.toStringAsFixed(2);
  }

  // Function to build currency selection row
  Widget buildCurrencySelection(
      String selectedCurrency, void Function(String) onSelected) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: currencies.map((currency) {
        final isSelected = selectedCurrency == currency;
        return GestureDetector(
          onTap: () => onSelected(currency),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: isSelected ? currencySelectionColor : Colors.transparent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/flags/$currency.png'),
                  radius: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  currency,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? currencySelectionColor : textColor,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w400,
                    decoration: isSelected
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildRateRow(String leftText, double rightValue, String fromCurrency,
      String toCurrency) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text(
              leftText,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
            Text(
              fromCurrency,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ]),
          Row(
            children: [
              Text(
                '${rightValue.toStringAsFixed(2)}',
                style: TextStyle(
                    color: toCurrencyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$toCurrency',
                style: TextStyle(
                    color: toCurrencyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Function to build rate list
  Widget buildRateList(Map<String, double> rates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRateRow('1 ', rates['EUR']! / rates['BRL']!, 'EUR', 'BRL'),
        buildRateRow('1 ', 1.0 / rates['BRL']!, 'USD', 'BRL'),
        buildRateRow('1 ', rates['GBP']! / rates['BRL']!, 'GBP', 'BRL'),
        buildRateRow('10 ', (rates['CNY']! / rates['BRL']!) * 10, 'CNY', 'BRL'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: currencySelectionColor,
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context)
                        .padding
                        .top), // This compensates for the status bar height
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Currency rates today',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<Map<String, double>>(
              future: fetchExchangeRates(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final rates = snapshot.data!;

                  // Introduce local variables to track the selected currencies
                  String localFromCurrency = fromCurrency;
                  String localToCurrency = toCurrency;

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRateList(rates),
                          const SizedBox(height: 16),
                          buildCurrencySelection(localFromCurrency, (currency) {
                            setState(() {
                              localFromCurrency = currency;
                            });
                          }),
                          const SizedBox(height: 16),
                          TextField(
                            controller: amountController,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Amount to convert',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(255, 255, 255, 0.1),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                fromCurrency = localFromCurrency;
                                toCurrency = localToCurrency;
                                convertCurrency(rates);
                              },
                              child: const Icon(Icons.swap_vert),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildCurrencySelection(localToCurrency, (currency) {
                            setState(() {
                              localToCurrency = currency;
                            });
                          }),
                          const SizedBox(height: 16),
                          TextField(
                            controller: resultController,
                            readOnly: true,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Converted amount',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              filled: true, // Enables background filling
                              fillColor: Color.fromRGBO(255, 255, 255,
                                  0.1), // Sets the background color
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ));
  }
}

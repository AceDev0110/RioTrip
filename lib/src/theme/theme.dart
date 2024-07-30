// theme.dart
import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  // Define the primary color for the entire app.
  primaryColor: primaryColor,

  // Define the primary swatch which will be used for primary color shades.
  primarySwatch: MaterialColor(primaryColor.value, {
    50: primaryColor.withOpacity(.1),
    100: primaryColor.withOpacity(.2),
    200: primaryColor.withOpacity(.3),
    300: primaryColor.withOpacity(.4),
    400: primaryColor.withOpacity(.5),
    500: primaryColor.withOpacity(.6),
    600: primaryColor.withOpacity(.7),
    700: primaryColor.withOpacity(.8),
    800: primaryColor.withOpacity(.9),
    900: primaryColor.withOpacity(1),
  }),

  // Define the default background color.
  scaffoldBackgroundColor: backgroundColor,

  // Update text theme with new parameter names if necessary.
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: textColor),
    // Add other text styles as needed
  ),

  // Optionally configure ElevatedButton text color with ButtonStyle.
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor, // Button background color
      foregroundColor: Colors.white, // Button text color
    ),
  ),

  // Configure other elements’ colors if necessary
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white, // Text and icon color
  ),
);

import 'package:flutter/material.dart';

import 'colors.dart';

final appTheme = ThemeData(
  primaryColor: primary,
  backgroundColor: black,
  scaffoldBackgroundColor: black,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.71,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 12,
      height: 1.33,
    ),
    headline2: TextStyle(
      color: primary,
      fontSize: 40,
      height: 1.2,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 18,
      height: 2.22,
    ),
    button: TextStyle(
      fontSize: 18,
      height: 1.33,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primary,
      onPrimary: black,
      onSurface: black,
      fixedSize: const Size.fromHeight(72),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: primary,
      onSurface: black,
      fixedSize: const Size.fromHeight(72),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      side: const BorderSide(
        color: primary,
      ),
    ),
  ),
);

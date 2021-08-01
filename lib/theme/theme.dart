import 'package:flutter/material.dart';

import 'colors.dart';

const textTheme = TextTheme(
  subtitle1: TextStyle(
    color: Colors.white,
    fontSize: 14,
    height: 1.71,
  ),
  subtitle2: TextStyle(
    fontSize: 10,
    height: 1.6,
    color: grey,
  ),
  bodyText1: TextStyle(
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
    fontSize: 32,
    height: 1.25,
    fontWeight: FontWeight.bold,
    letterSpacing: 9.6,
    color: black,
  ),
  headline4: TextStyle(
    fontSize: 24,
    height: 2,
    fontWeight: FontWeight.bold,
    color: primary,
  ),
  headline5: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 2.22,
  ),
  button: TextStyle(
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.bold,
  ),
);

final appTheme = ThemeData(
  primaryColor: primary,
  backgroundColor: black,
  scaffoldBackgroundColor: black,
  fontFamily: 'Roboto',
  brightness: Brightness.dark,
  textTheme: textTheme,
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
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: Colors.red),
    ),
    labelStyle: textTheme.bodyText2,
    isDense: true,
    errorStyle: textTheme.subtitle2!.copyWith(color: Colors.red),
    alignLabelWithHint: true,
  ),
);

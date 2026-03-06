import 'package:flutter/material.dart';

// Couleurs alignées sur le frontend web (tailwind.config.js)
const jiPrimary = Color(0xFF0A1D37); // primary.DEFAULT
const jiPrimaryLight = Color(0xFF1A3E7B); // primary.light
const jiSecondary = Color(0xFF0066FF); // secondary.DEFAULT
const jiSecondaryLight = Color(0xFFE6F0FF); // secondary.light

ThemeData buildJiTheme(Brightness brightness) {
  final base =
      brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();

  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: jiSecondary,
      brightness: brightness,
      primary: jiPrimary,
      secondary: jiSecondary,
    ),
    scaffoldBackgroundColor:
        brightness == Brightness.dark ? const Color(0xFF050915) : jiPrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: jiPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: base.textTheme.apply(
      fontFamily: 'Inter',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    useMaterial3: true,
  );
}


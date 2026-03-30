import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Couleurs alignées sur le frontend web (tailwind.config.js)
const jiPrimary = Color(0xFF0A1D37); // primary.DEFAULT
const jiPrimaryLight = Color(0xFF1A3E7B); // primary.light
const jiSecondary = Color(0xFF0066FF); // secondary.DEFAULT
const jiSecondaryLight = Color(0xFFE6F0FF); // secondary.light

ThemeData buildJiTheme(Brightness brightness) {
  final base = brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();

  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: jiSecondary,
      error: Colors.red,
      surface: Colors.white,
      brightness: brightness,
      primary: jiPrimary,
      secondary: jiSecondary,
    ),
    scaffoldBackgroundColor:
        brightness == Brightness.dark ? jiPrimary : jiSecondaryLight,
    appBarTheme: AppBarTheme(
      backgroundColor: brightness == Brightness.dark ? jiPrimary : Colors.white,
      foregroundColor: brightness == Brightness.dark ? Colors.white : jiPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: base.textTheme.apply(
      fontFamily: 'Inter',
      bodyColor: brightness == Brightness.dark ? Colors.white : jiPrimary,
      displayColor: brightness == Brightness.dark ? Colors.white : jiPrimary,
    ),
    useMaterial3: true,
  );
}


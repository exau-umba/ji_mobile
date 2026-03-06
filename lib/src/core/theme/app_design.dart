import 'package:flutter/material.dart';

/// Variables de design réutilisables : tailles de texte, espacements, rayons, etc.
/// À importer via : import '.../core/theme/app_design.dart';

// ——— Tailles de texte ———
const double kFontSizeDisplayLarge = 28;
const double kFontSizeDisplayMedium = 24;
const double kFontSizeTitleLarge = 20;
const double kFontSizeTitleMedium = 18;
const double kFontSizeBodyLarge = 16;
const double kFontSizeBodyMedium = 15;
const double kFontSizeBodySmall = 14;
const double kFontSizeLabel = 12;
const double kFontSizeCaption = 11;

// ——— Hauteur de ligne (line height) ———
const double kLineHeightTight = 1.2;
const double kLineHeightNormal = 1.4;
const double kLineHeightRelaxed = 1.5;

// ——— Espacements (padding / margin / gap) ———
const double kSpaceXS = 4;
const double kSpaceS = 8;
const double kSpaceM = 12;
const double kSpaceL = 16;
const double kSpaceXL = 24;
const double kSpaceXXL = 32;

// ——— Rayons de bordure ———
const double kRadiusS = 10;
const double kRadiusM = 16;
const double kRadiusL = 18;
const double kRadiusXL = 24;
const double kRadiusXXL = 32;

// ——— Composants ———
const double kButtonHeightPrimary = 56;
const double kIndicatorSize = 8;
const double kIndicatorSizeActive = 24;
const double kLogoHeightHeader = 60;
const double kLogoSplashWidth = 100;
const double kIconSizeMedium = 20;
const double kIconSizeLarge = 80;

// ——— Durées d'animation (millisecondes) ———
const int kDurationShort = 300;
const int kDurationMedium = 500;

// ——— Styles de texte prédéfinis (pour réutilisation) ———
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: kFontSizeDisplayLarge,
    height: kLineHeightTight,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: kFontSizeDisplayMedium,
    height: kLineHeightTight,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: kFontSizeTitleLarge,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: kFontSizeTitleMedium,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: kFontSizeBodyLarge,
    height: kLineHeightNormal,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: kFontSizeBodyMedium,
    height: kLineHeightRelaxed,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: kFontSizeBodySmall,
    height: kLineHeightNormal,
  );

  static const TextStyle label = TextStyle(
    fontSize: kFontSizeLabel,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: kFontSizeCaption,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: kFontSizeBodyLarge,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}

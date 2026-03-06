import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Fond style tech pour les écrans auth : image bg_tech.jpg + overlay sombre.
/// Si l'image est absente, affiche un dégradé bleu.
class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/bg_tech.jpg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [jiPrimary, jiPrimaryLight],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                jiPrimary.withOpacity(0.85),
                jiPrimaryLight.withOpacity(0.9),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

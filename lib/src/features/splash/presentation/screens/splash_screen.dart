import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_design.dart';

/// Splash screen affichée au lancement de l'app.
/// Logo centré, signature "Développé par Exaucé Umba" en bas.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Précharger le logo pour éviter les cas où il ne s'affiche pas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/icon/JI_LOGO.png'), context);
    });
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (!mounted) return;
    context.goNamed('onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              // Logo centré (couleurs d'origine, sans filtre)
              Center(
                child: Image.asset(
                  'assets/icon/JI_LOGO.png',
                  width: kLogoSplashWidth,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.image_not_supported_outlined,
                    size: kIconSizeLarge,
                  ),
                ),
              ),
              const SizedBox(height: kSpaceXL),
              // Loading linéaire en bas du logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 125),
                child: LinearProgressIndicator(
                  backgroundColor: jiSecondaryLight,
                  borderRadius: BorderRadius.circular(kRadiusS),
                  valueColor: AlwaysStoppedAnimation<Color>(jiSecondary),
                  minHeight: 2,
                ),
              ),
              const Spacer(),
              // Signature en bas
              Padding(
                padding: const EdgeInsets.only(bottom: kSpaceXXL),
                child: Text(
                  '${DateTime.now().year} © Journées Informatiques\n Développée par Exaucé Umba',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppInsets.screen.copyWith(top: kSpaceL, bottom: kSpaceXL),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                  color: jiSecondaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kSpaceS),
                  child: Image.asset('assets/icon/JI_MINI_LOGO.png'),
                ),
              ),
              const SizedBox(height: kSpaceM),
              Text(
                'Journées Informatiques',
                style: AppTextStyles.titleLarge.copyWith(color: jiPrimary),
              ),
              const SizedBox(height: kSpaceXS),
              Text(
                'Version 1.0.0',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: kSpaceXL),
        _infoCard(
          icon: FontAwesomeIcons.circleInfo,
          title: 'À propos de l’application',
          content:
              'JI Mobile est la plateforme officielle des Journées Informatiques '
              'pour gérer le programme, les annonces, le badge QR et les interactions.',
        ),
        const SizedBox(height: kSpaceS),
        _infoCard(
          icon: FontAwesomeIcons.code,
          title: 'Développement',
          content: 'Développé par Exaucé Umba',
        ),
        const SizedBox(height: kSpaceS),
        _infoCard(
          icon: FontAwesomeIcons.shieldHalved,
          title: 'Confidentialité',
          content:
              'Vos données sont utilisées uniquement pour le bon déroulement de '
              'l’événement et la personnalisation de votre expérience.',
        ),
      ],
    );
  }
}

Widget _infoCard({
  required IconData icon,
  required String title,
  required String content,
}) {
  return Container(
    padding: AppInsets.allM,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(kRadiusL),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(icon, size: 16, color: jiPrimary),
            const SizedBox(width: kSpaceS),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(color: jiPrimary),
              ),
            ),
          ],
        ),
        const SizedBox(height: kSpaceS),
        Text(
          content,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class AnnonceDetailScreen extends StatelessWidget {
  final String annonceId;

  const AnnonceDetailScreen({
    super.key,
    required this.annonceId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: charger les détails de l’annonce via l’API en utilisant annonceId.
    const titre = 'Programme de la journée';
    const contenu =
        'Voici le programme détaillé pour la journée : conférences, ateliers, '
        'démo startups et moments de networking. Restez connectés pour les mises à jour.';

    return Padding(
      padding: AppInsets.screen.copyWith(top: kSpaceL, bottom: kSpaceXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: AppTextStyles.titleLarge.copyWith(color: jiPrimary),
          ),
          const SizedBox(height: kSpaceM),
          Text(
            contenu,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: kButtonHeightPrimary,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(
                  'annonce-comments',
                  pathParameters: {'id': annonceId},
                  queryParameters: {'title': titre},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: jiSecondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusL),
                ),
              ),
              child: const Text(
                'Ouvrir les commentaires',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


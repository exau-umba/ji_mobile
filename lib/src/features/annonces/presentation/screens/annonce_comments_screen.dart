import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class AnnonceCommentsScreen extends StatelessWidget {
  final String annonceId;

  const AnnonceCommentsScreen({
    super.key,
    required this.annonceId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: remplacer par des commentaires réels venant du backend.
    final fakeComments = List.generate(
      10,
      (index) => 'Commentaire ${index + 1} sur l’annonce $annonceId',
    );

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: AppInsets.screen.copyWith(top: kSpaceL),
            itemCount: fakeComments.length,
            separatorBuilder: (_, __) => const SizedBox(height: kSpaceS),
            itemBuilder: (context, index) {
              final comment = fakeComments[index];
              return Align(
                alignment: index.isEven
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 260),
                  padding: AppInsets.allM,
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? jiSecondaryLight
                        : jiSecondary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(kRadiusL),
                  ),
                  child: Text(
                    comment,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: jiPrimary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: AppInsets.screen.copyWith(bottom: kSpaceM, top: kSpaceS),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Écrire un commentaire...',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey.shade500,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: kSpaceM,
                      vertical: kSpaceS,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusL),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusL),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadiusL),
                      borderSide: const BorderSide(
                        color: jiSecondary,
                        width: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: kSpaceS),
              SizedBox(
                height: kButtonHeightPrimary,
                width: kButtonHeightPrimary,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: envoyer le commentaire via l’API.
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: jiSecondary,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.paperPlane,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


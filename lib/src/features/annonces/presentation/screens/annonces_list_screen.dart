import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class AnnoncesListScreen extends StatelessWidget {
  const AnnoncesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: remplacer par un fetch API réel
    final fakeAnnonces = <_FakeAnnonce>[
      _FakeAnnonce(
        id: '1',
        titre: 'Ouverture officielle des JI',
        description:
            'Cérémonie d’ouverture, mot de bienvenue et présentation du programme.',
        reactionsCount: 124,
        commentsCount: 18,
        imagePath: 'assets/images/Gemini_Generated_Image_2y4cno2y4cno2y4c.png',
        publishedAt: DateTime(2026, 3, 10, 9, 35),
      ),
      _FakeAnnonce(
        id: '2',
        titre: 'Conférence IA & Startups',
        description:
            'Panel sur l’impact de l’intelligence artificielle dans les startups africaines.',
        reactionsCount: 89,
        commentsCount: 25,
        imagePath: 'assets/images/Gemini_Generated_Image_chewkfchewkfchew.png',
        publishedAt: DateTime(2026, 3, 10, 11, 15),
      ),
      _FakeAnnonce(
        id: '3',
        titre: 'Atelier Flutter pour débutants',
        description:
            'Hands-on pour créer sa première application mobile avec Flutter.',
        reactionsCount: 57,
        commentsCount: 9,
        imagePath: null, // annonce sans photo
        publishedAt: DateTime(2026, 3, 10, 13, 0),
      ),
      _FakeAnnonce(
        id: '4',
        titre: 'Session Networking',
        description:
            'Moment d’échanges avec les sponsors, startups et étudiants.',
        reactionsCount: 72,
        commentsCount: 14,
        imagePath: 'assets/images/Gemini_Generated_Image_dov5l5dov5l5dov5.png',
        publishedAt: DateTime(2026, 3, 10, 15, 30),
      ),
      _FakeAnnonce(
        id: '5',
        titre: 'Clôture & Remise des prix',
        description:
            'Résultats des concours, remerciements et photo de famille.',
        reactionsCount: 133,
        commentsCount: 32,
        imagePath: 'assets/images/Gemini_Generated_Image_lhhuw5lhhuw5lhhu.png',
        publishedAt: DateTime(2026, 3, 10, 18, 0),
      ),
    ];

    return ListView.separated(
      padding: AppInsets.screen.copyWith(top: kSpaceL),
      itemCount: fakeAnnonces.length,
      separatorBuilder: (_, __) => const SizedBox(height: kSpaceXL),
      itemBuilder: (context, index) {
        final annonce = fakeAnnonces[index];
        if (annonce.imagePath == null) {
          return InkWell(
            onTap: () {
              context.pushNamed(
                'annonce-detail',
                pathParameters: {'id': annonce.id},
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceS,
                vertical: kSpaceXS,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    annonce.titre,
                    style: AppTextStyles.titleMedium.copyWith(color: jiPrimary),
                  ),
                  const SizedBox(height: kSpaceXS),
                  Text(
                    annonce.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: kSpaceXS),
                  Text(
                    _formatDateTime(annonce.publishedAt),
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: kSpaceS),
                  SizedBox(
                    width: double.infinity,
                    height: kButtonHeightPrimary * 0.7,
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                          'annonce-comments',
                          pathParameters: {'id': annonce.id},
                          queryParameters: {'title': annonce.titre},
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: jiSecondaryLight),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Commentaires',
                          style: AppTextStyles.button.copyWith(
                            color: jiSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: kSpaceXS),
                  Row(
                    children: [
                      const _ReactionEmoji('👍'),
                      const SizedBox(width: kSpaceXS),
                      const _ReactionEmoji('🔥'),
                      const SizedBox(width: kSpaceXS),
                      const _ReactionEmoji('❤️'),
                      const SizedBox(width: kSpaceS),
                      Text(
                        '${annonce.reactionsCount}',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return InkWell(
          onTap: () {
            context.pushNamed(
              'annonce-detail',
              pathParameters: {'id': annonce.id},
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRadiusL),
            ),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Photo — pleine largeur en haut (partie intégrante du card)
                _buildPhotoSection(annonce.imagePath),

                // 2. Bloc texte : Titre, Description, Date (cliquable → détail)
                Padding(
                  padding: const EdgeInsets.only(top: kSpaceM),
                  child: Text(
                    annonce.titre,
                    style: AppTextStyles.titleMedium.copyWith(color: jiPrimary),
                  ),
                ),
                const SizedBox(height: kSpaceS),
                Text(
                  annonce.description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: kSpaceS),
                Text(
                  _formatDateTime(annonce.publishedAt),
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),

                // 3. Barre "Commentaires" pleine largeur (partie intégrante du card)
                SizedBox(
                  width: double.infinity,
                  height: kButtonHeightPrimary * 0.8,
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(
                        'annonce-comments',
                        pathParameters: {'id': annonce.id},
                        queryParameters: {'title': annonce.titre},
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: jiSecondaryLight,
                        border: Border(top: BorderSide(color: jiSecondaryLight)),
                      ),
                      margin: const EdgeInsets.only(top: kSpaceS),
                      child: Center(
                        child: Text(
                          'Commentaires',
                          style: AppTextStyles.button.copyWith(
                            color: jiSecondary
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // 4. Ligne emojis en bas du card
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    kSpaceL,
                    kSpaceS,
                    kSpaceL,
                    kSpaceM,
                  ),
                  child: Row(
                    children: [
                      const _ReactionEmoji('👍'),
                      const SizedBox(width: kSpaceXS),
                      const _ReactionEmoji('🔥'),
                      const SizedBox(width: kSpaceXS),
                      const _ReactionEmoji('❤️'),
                      const SizedBox(width: kSpaceS),
                      Text(
                        '${annonce.reactionsCount}',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FakeAnnonce {
  final String id;
  final String titre;
  final String description;
  final int reactionsCount;
  final int commentsCount;
  final String? imagePath;
  final DateTime publishedAt;

  _FakeAnnonce({
    required this.id,
    required this.titre,
    required this.description,
    required this.reactionsCount,
    required this.commentsCount,
    required this.imagePath,
    required this.publishedAt,
  });
}

class _ReactionEmoji extends StatelessWidget {
  final String emoji;

  const _ReactionEmoji(this.emoji);

  @override
  Widget build(BuildContext context) {
    return Text(emoji, style: const TextStyle(fontSize: 16));
  }
}

Widget _buildPhotoSection(String? imagePath) {
  const aspectRatio = 16 / 9;
  return AspectRatio(
    aspectRatio: aspectRatio,
    child:
        imagePath != null
            ? Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => _buildPhotoPlaceholder(),
            )
            : _buildPhotoPlaceholder(),
  );
}

Widget _buildPhotoPlaceholder() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [jiPrimary.withOpacity(0.6), jiPrimaryLight.withOpacity(0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: Text(
        'Photo',
        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
      ),
    ),
  );
}

String _formatDateTime(DateTime dateTime) {
  final hours = dateTime.hour.toString().padLeft(2, '0');
  final minutes = dateTime.minute.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final year = dateTime.year.toString();
  return '$hours:$minutes · $day/$month/$year';
}

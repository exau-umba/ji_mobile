import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_AgendaItem>[
      _AgendaItem(
        time: '09:00',
        title: 'Ouverture officielle',
        place: 'Salle Monekosso',
        type: 'Plénière',
      ),
      _AgendaItem(
        time: '11:00',
        title: 'Conférence IA & Startups',
        place: 'Amphi A',
        type: 'Conférence',
      ),
      _AgendaItem(
        time: '13:00',
        title: 'Atelier Flutter',
        place: 'Lab Mobile',
        type: 'Atelier',
      ),
      _AgendaItem(
        time: '15:30',
        title: 'Networking',
        place: 'Hall principal',
        type: 'Rencontre',
      ),
    ];

    return ListView.separated(
      padding: AppInsets.screen.copyWith(top: kSpaceL, bottom: kSpaceXL),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: kSpaceS),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: AppInsets.allM,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kRadiusL),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 62,
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpaceS,
                  vertical: kSpaceXS,
                ),
                decoration: BoxDecoration(
                  color: jiSecondaryLight,
                  borderRadius: BorderRadius.circular(kRadiusM),
                ),
                child: Text(
                  item.time,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: jiPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: kSpaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyles.titleMedium.copyWith(color: jiPrimary),
                    ),
                    const SizedBox(height: kSpaceXS),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: kSpaceXS),
                        Expanded(
                          child: Text(
                            item.place,
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kSpaceXS),
                    Text(
                      item.type,
                      style: AppTextStyles.caption.copyWith(
                        color: jiSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AgendaItem {
  final String time;
  final String title;
  final String place;
  final String type;

  _AgendaItem({
    required this.time,
    required this.title,
    required this.place,
    required this.type,
  });
}


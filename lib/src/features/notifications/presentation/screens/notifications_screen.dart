import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = <_NotificationItem>[
      _NotificationItem(
        title: 'Nouvelle annonce publiée',
        body: 'Le programme du jour 2 vient d’être publié.',
        time: 'Il y a 5 min',
        icon: FontAwesomeIcons.bullhorn,
        unread: true,
      ),
      _NotificationItem(
        title: 'Rappel atelier',
        body: 'Atelier Flutter pour débutants à 13h00.',
        time: 'Il y a 20 min',
        icon: FontAwesomeIcons.clock,
        unread: true,
      ),
      _NotificationItem(
        title: 'Badge validé',
        body: 'Votre badge QR a été validé avec succès.',
        time: 'Hier',
        icon: FontAwesomeIcons.solidCircleCheck,
        unread: false,
      ),
    ];

    return ListView.separated(
      padding: AppInsets.screen.copyWith(top: kSpaceL, bottom: kSpaceXL),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: kSpaceS),
      itemBuilder: (context, index) {
        final item = notifications[index];
        return Container(
          padding: AppInsets.allM,
          decoration: BoxDecoration(
            color: item.unread ? const Color(0xFFF4F8FF) : Colors.white,
            borderRadius: BorderRadius.circular(kRadiusL),
            border: Border.all(
              color: item.unread ? jiSecondaryLight : Colors.grey.shade200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: item.unread
                      ? jiSecondary.withOpacity(0.16)
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    height: 18,
                    width: 18,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: FaIcon(
                        item.icon,
                        color: item.unread ? jiSecondary : jiPrimary,
                      ),
                    ),
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
                      style: AppTextStyles.titleMedium.copyWith(
                        color: jiPrimary,
                        fontWeight: item.unread ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: kSpaceXS),
                    Text(
                      item.body,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: kSpaceXS),
                    Text(
                      item.time,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.unread)
                Container(
                  margin: const EdgeInsets.only(left: kSpaceS, top: kSpaceXS),
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: jiSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _NotificationItem {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final bool unread;

  _NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.unread,
  });
}


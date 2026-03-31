import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.08,
            child: Image.asset(
              'assets/icon/JI_MINI_LOGO.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.white.withOpacity(0.92)),
        ),
        ListView(
          padding: AppInsets.screen.copyWith(top: kSpaceL),
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 44,
                    backgroundColor: jiSecondaryLight,
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: jiPrimary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: kSpaceM),
                  Text(
                    'Exaucé Umba',
                    style: AppTextStyles.titleLarge.copyWith(color: jiPrimary),
                  ),
                  const SizedBox(height: kSpaceXS),
                  Text(
                    'Étudiant · Université de Kinshasa',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpaceXL),
            _ProfileTile(
              icon: FontAwesomeIcons.userPen,
              title: 'Modifier mon profil',
              onTap: () {},
            ),
            _ProfileTile(
              icon: FontAwesomeIcons.qrcode,
              title: 'Mon badge QR',
              onTap: () => context.pushNamed('profile-qr-badge'),
            ),
            _ProfileTile(
              icon: FontAwesomeIcons.bell,
              title: 'Notifications',
              onTap: () => context.pushNamed('notifications'),
            ),
            _ProfileTile(
              icon: FontAwesomeIcons.gear,
              title: 'Paramètres',
              onTap: () {},
            ),
            const SizedBox(height: kSpaceL),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.rightFromBracket,
                size: 16,
                color: Colors.red,
              ),
              label: const Text('Se déconnecter'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusL),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: kSpaceS),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusL),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,
        leading: FaIcon(icon, color: jiPrimary, size: 18),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(color: jiPrimary),
        ),
        trailing: const FaIcon(
          FontAwesomeIcons.angleRight,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}


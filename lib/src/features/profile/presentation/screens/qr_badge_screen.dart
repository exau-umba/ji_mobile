import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class QrBadgeScreen extends StatelessWidget {
  const QrBadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kSpaceL,
              vertical: kSpaceM,
            ),
            color: jiPrimary,
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.ticket,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: kSpaceS),
                Expanded(
                  child: Text(
                    'Badge d’accès JI 2026',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              kSpaceL,
              kSpaceL,
              kSpaceL,
              kSpaceM,
            ),
            child: Column(
              children: [
                _infoRow('Nom', 'Exaucé Umba'),
                const SizedBox(height: kSpaceS),
                _infoRow('Type', 'Étudiant'),
                const SizedBox(height: kSpaceS),
                _infoRow('Institution', 'Université de Kinshasa'),
                const SizedBox(height: kSpaceS),
                _infoRow('Date', '18 mars 2026'),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              kSpaceL,
              kSpaceM,
              kSpaceL,
              kSpaceXL,
            ),
            child: Column(
              children: [
                Text(
                  'Scannez ce QR à l’entrée',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: kSpaceM),
                Container(
                  height: 170,
                  width: 170,
                  padding: const EdgeInsets.all(kSpaceS),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kRadiusM),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.qrcode,
                      size: 120,
                      color: jiPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: kSpaceS),
                Text(
                  'JI-2026-UMB-0001',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.grey.shade600,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _infoRow(String label, String value) {
  return Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          value,
          textAlign: TextAlign.right,
          style: AppTextStyles.bodyMedium.copyWith(color: jiPrimary),
        ),
      ),
    ],
  );
}


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _soundEnabled = false;
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppInsets.screen.copyWith(top: kSpaceL, bottom: kSpaceXL),
      children: [
        _sectionTitle('Préférences'),
        _switchTile(
          icon: FontAwesomeIcons.bell,
          title: 'Notifications push',
          value: _pushEnabled,
          onChanged: (value) => setState(() => _pushEnabled = value),
        ),
        _switchTile(
          icon: FontAwesomeIcons.envelope,
          title: 'Notifications email',
          value: _emailEnabled,
          onChanged: (value) => setState(() => _emailEnabled = value),
        ),
        _switchTile(
          icon: FontAwesomeIcons.volumeHigh,
          title: 'Son des alertes',
          value: _soundEnabled,
          onChanged: (value) => setState(() => _soundEnabled = value),
        ),
        const SizedBox(height: kSpaceL),
        _sectionTitle('Compte'),
        _actionTile(
          icon: FontAwesomeIcons.lock,
          title: 'Changer le mot de passe',
          onTap: () => context.pushNamed('settings-change-password'),
        ),
        _actionTile(
          icon: FontAwesomeIcons.language,
          title: 'Langue',
          subtitle: _selectedLanguage,
          onTap: _showLanguageDialog,
        ),
        _actionTile(
          icon: FontAwesomeIcons.circleInfo,
          title: 'À propos',
          subtitle: 'Version 1.0.0',
          onTap: () => context.pushNamed('settings-about'),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceS),
      child: Text(
        text,
        style: AppTextStyles.titleMedium.copyWith(color: jiPrimary),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: kSpaceS),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusL),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: FaIcon(icon, color: jiPrimary, size: 18),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(color: jiPrimary),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: jiSecondary,
        ),
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
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
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(color: Colors.grey.shade600),
              ),
        trailing: const FaIcon(
          FontAwesomeIcons.angleRight,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    final languages = ['Français', 'English', 'Swahili', 'Lingala'];
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Choisir la langue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((lang) {
              return RadioListTile<String>(
                value: lang,
                groupValue: _selectedLanguage,
                activeColor: jiSecondary,
                title: Text(lang),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedLanguage = value);
                  Navigator.of(dialogContext).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}


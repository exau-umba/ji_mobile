import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppInsets.screen.copyWith(top: kSpaceL, bottom: kSpaceXL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              _passwordField(
                label: 'Mot de passe actuel',
                controller: _currentController,
                visible: _showCurrent,
                icon: FontAwesomeIcons.lock,
                onToggleVisibility: () {
                  setState(() => _showCurrent = !_showCurrent);
                },
              ),
              const SizedBox(height: kSpaceM),
              _passwordField(
                label: 'Nouveau mot de passe',
                controller: _newController,
                visible: _showNew,
                icon: FontAwesomeIcons.key,
                onToggleVisibility: () {
                  setState(() => _showNew = !_showNew);
                },
              ),
              const SizedBox(height: kSpaceM),
              _passwordField(
                label: 'Confirmer le mot de passe',
                controller: _confirmController,
                visible: _showConfirm,
                icon: FontAwesomeIcons.shieldHalved,
                onToggleVisibility: () {
                  setState(() => _showConfirm = !_showConfirm);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  if (value != _newController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kSpaceXL),
              SizedBox(
                width: double.infinity,
                height: kButtonHeightPrimary,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mot de passe modifié avec succès'),
                        ),
                      );
                    }
                  },
                  icon: const FaIcon(FontAwesomeIcons.key, size: 16),
                  label: const Text(
                    'Mettre à jour le mot de passe',
                    style: AppTextStyles.button,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: jiSecondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusL),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool visible,
    required VoidCallback onToggleVisibility,
    IconData icon = FontAwesomeIcons.lock,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !visible,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Ce champ est requis';
            }
            if (value.length < 8) {
              return 'Minimum 8 caractères';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: kSpaceM, right: kSpaceS),
          child: SizedBox(
            height: 16,
            width: 16,
            child: FittedBox(
              fit: BoxFit.contain,
              child: FaIcon(icon, color: jiPrimary),
            ),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: FaIcon(
            visible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
            size: 16,
            color: Colors.grey.shade600,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusL),
        ),
      ),
    );
  }
}


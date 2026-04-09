import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_design.dart';
import '../../../../core/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: 'Exaucé');
  final _lastNameController = TextEditingController(text: 'Umba');
  final _emailController = TextEditingController(text: 'exauce.umba@gmail.com');
  final _universityController = TextEditingController(
    text: 'Université de Kinshasa',
  );
  final _fieldController = TextEditingController(text: 'Informatique');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _universityController.dispose();
    _fieldController.dispose();
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
              _buildField(
                label: 'Prénom',
                controller: _firstNameController,
                icon: FontAwesomeIcons.user,
              ),
              const SizedBox(height: kSpaceM),
              _buildField(
                label: 'Nom',
                controller: _lastNameController,
                icon: FontAwesomeIcons.userTag,
              ),
              const SizedBox(height: kSpaceM),
              _buildField(
                label: 'Email',
                controller: _emailController,
                icon: FontAwesomeIcons.envelope,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: kSpaceM),
              _buildField(
                label: 'Université',
                controller: _universityController,
                icon: FontAwesomeIcons.buildingColumns,
              ),
              const SizedBox(height: kSpaceM),
              _buildField(
                label: 'Filière',
                controller: _fieldController,
                icon: FontAwesomeIcons.bookOpenReader,
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
                          content: Text('Profil mis à jour avec succès'),
                        ),
                      );
                    }
                  },
                  icon: const FaIcon(FontAwesomeIcons.floppyDisk, size: 16),
                  label: const Text(
                    'Enregistrer les modifications',
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

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Ce champ est requis';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade700),
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
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusL),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusL),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRadiusL)),
          borderSide: BorderSide(color: jiSecondary, width: 1.4),
        ),
      ),
    );
  }
}


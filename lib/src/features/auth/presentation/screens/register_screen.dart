import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_design.dart';
import '../widgets/auth_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;
  String _selectedProfileType = 'student';

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final List<Map<String, String>> _profileTypes = [
    {'value': 'student', 'label': 'Étudiant'},
    {'value': 'entrepreneur', 'label': 'Entrepreneur'},
    {'value': 'startup', 'label': 'Startup'},
    {'value': 'sponsor', 'label': 'Sponsor'},
  ];

  /// Pattern email simple et courant (local@domain).
  static final _regEmail = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailOrPasswordChanged);
    _passwordController.addListener(_onEmailOrPasswordChanged);
    _confirmPasswordController.addListener(_onEmailOrPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailOrPasswordChanged);
    _passwordController.removeListener(_onEmailOrPasswordChanged);
    _confirmPasswordController.removeListener(_onEmailOrPasswordChanged);
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onEmailOrPasswordChanged() => setState(() {});

  bool _isEmailValid(String email) => email.isNotEmpty && _regEmail.hasMatch(email.trim());

  /// Règles : 8 car. min, 1 majuscule, 1 minuscule, 1 chiffre, 1 caractère spécial.
  static final _regUpper = RegExp(r'[A-Z]');
  static final _regLower = RegExp(r'[a-z]');
  static final _regDigit = RegExp(r'[0-9]');
  static final _regSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\;/`~]');

  _PasswordStrength _passwordStrength(String password) {
    if (password.isEmpty) {
      return _PasswordStrength(label: '', progress: 0, color: Colors.grey);
    }
    final hasMinLen = password.length >= 8;
    final hasUpper = _regUpper.hasMatch(password);
    final hasLower = _regLower.hasMatch(password);
    final hasDigit = _regDigit.hasMatch(password);
    final hasSpecial = _regSpecial.hasMatch(password);
    final count = [hasMinLen, hasUpper, hasLower, hasDigit, hasSpecial].where((e) => e).length;
    if (count <= 2) return _PasswordStrength(label: 'Faible', progress: count / 5, color: Colors.red.shade700);
    if (count <= 4) return _PasswordStrength(label: 'Moyen', progress: count / 5, color: Colors.orange.shade700);
    return _PasswordStrength(label: 'Fort', progress: 1.0, color: Colors.green.shade700);
  }

  Widget _buildPasswordStrengthBar() {
    final password = _passwordController.text;
    final strength = _passwordStrength(password);
    if (password.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: kSpaceS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: strength.progress,
                  backgroundColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(kRadiusM),
                  valueColor: AlwaysStoppedAnimation<Color>(strength.color),
                  minHeight: 2,
                ),
              ),
              const SizedBox(width: kSpaceM),
              Text(
                strength.label,
                style: TextStyle(
                  fontSize: kFontSizeBodySmall,
                  fontWeight: FontWeight.w600,
                  color: strength.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: kSpaceXS),
          Text(
            'Au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial.',
            style: TextStyle(
              fontSize: kFontSizeLabel,
              color: Colors.grey.shade600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailValidationIndicator() {
    final email = _emailController.text.trim();
    if (email.isEmpty) return const SizedBox.shrink();
    final valid = _isEmailValid(email);
    return Padding(
      padding: const EdgeInsets.only(top: kSpaceS),
      child: Row(
        children: [
          Icon(
            valid ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.solidCircleXmark,
            size: 16,
            color: valid ? Colors.green.shade700 : Colors.red.shade700,
          ),
          const SizedBox(width: kSpaceS),
          Text(
            valid ? 'Email valide' : 'Email invalide',
            style: TextStyle(
              fontSize: kFontSizeBodySmall,
              fontWeight: FontWeight.w600,
              color: valid ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmMatchIndicator() {
    final confirm = _confirmPasswordController.text;
    final password = _passwordController.text;
    if (confirm.isEmpty) return const SizedBox.shrink();
    final match = password == confirm;
    return Padding(
      padding: const EdgeInsets.only(top: kSpaceS),
      child: Row(
        children: [
          Icon(
            match ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.solidCircleXmark,
            size: 16,
            color: match ? Colors.green.shade700 : Colors.red.shade700,
          ),
          const SizedBox(width: kSpaceS),
          Text(
            match ? 'Correspond' : 'Ne correspond pas',
            style: TextStyle(
              fontSize: kFontSizeBodySmall,
              fontWeight: FontWeight.w600,
              color: match ? Colors.green.shade700 : Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      style: const TextStyle(color: jiPrimary, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF5F7FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusM),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kRadiusM),
          borderSide: BorderSide(color: colorScheme.secondary, width: 1.5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: const AuthBackground()),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.20,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.goNamed('login');
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 20),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kSpaceXL),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Créez votre compte',
                               textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  // backgroundColor: jiSecondary,
                                  fontSize: kFontSizeDisplayLarge,
                                  fontWeight: FontWeight.w800,
                                  height: kLineHeightTight,
                                ),
                              ),
                              const SizedBox(height: kSpaceS),
                              Text(
                                'Rejoignez la plateforme JI 2026 pour profiter des événements.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  // backgroundColor: jiSecondary,

                                  fontSize: kFontSizeBodySmall,
                                  height: kLineHeightNormal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(kSpaceXL, kSpaceXXL, kSpaceXL, 0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kRadiusXXL),
                        topRight: Radius.circular(kRadiusXXL),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Noms
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _firstNameController,
                              labelText: 'Prénom',
                            ),
                          ),
                          const SizedBox(width: kSpaceL),
                          Expanded(
                            child: _buildTextField(
                              controller: _lastNameController,
                              labelText: 'Nom',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kSpaceL),

                      // Email
                      _buildTextField(
                        controller: _emailController,
                        labelText: 'Adresse email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildEmailValidationIndicator(),
                      const SizedBox(height: kSpaceL),

                      // Téléphone
                      _buildTextField(
                        controller: _phoneController,
                        labelText: 'Téléphone',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: kSpaceL),

                      // Type de profil
                      DropdownButtonFormField<String>(
                        value: _selectedProfileType,
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down_rounded, color: colorScheme.secondary),
                        style: const TextStyle(color: jiPrimary, fontWeight: FontWeight.w500, fontSize: kFontSizeBodyLarge),
                        decoration: InputDecoration(
                          labelText: 'Je suis un(e)...',
                          labelStyle: TextStyle(color: Colors.grey.shade600),
                          filled: true,
                          fillColor: const Color(0xFFF5F7FB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusM),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadiusM),
                            borderSide: BorderSide(color: colorScheme.secondary, width: 1.5),
                          ),
                        ),
                        items: _profileTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type['value'],
                            child: Text(
                              type['label']!,
                              style: const TextStyle(color: jiPrimary, fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) _selectedProfileType = value;
                          });
                        },
                      ),
                      const SizedBox(height: kSpaceL),

                      // Mot de passe
                      _buildTextField(
                        controller: _passwordController,
                        labelText: 'Mot de passe',
                        obscureText: !_isPasswordVisible,
                        textInputAction: TextInputAction.next,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
                            color: jiSecondary,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      _buildPasswordStrengthBar(),
                      const SizedBox(height: kSpaceL),

                      // Confirmation mot de passe
                      _buildTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Confirmer le mot de passe',
                        obscureText: !_isPasswordVisible,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
                            color: jiSecondary,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      _buildConfirmMatchIndicator(),
                      const SizedBox(height: kSpaceXXL),

                      // Bouton Inscription
                      SizedBox(
                        height: kButtonHeightPrimary,
                        child: ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            final confirm = _confirmPasswordController.text.trim();
                            final strength = _passwordStrength(password);
                            if (!_isEmailValid(email)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Veuillez entrer une adresse email valide.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red.shade700,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }
                            if (strength.label != 'Fort') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Le mot de passe doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red.shade700,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 4),
                                ),
                              );
                              return;
                            }
                            if (password != confirm) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Les mots de passe ne correspondent pas.', style: TextStyle(color: Colors.white)),
                                  backgroundColor: Colors.red.shade700,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }
                            // TODO: valider le formulaire et appeler l'API d'inscription
                            context.goNamed('dashboard');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.secondary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(kRadiusM),
                            ),
                          ),
                          child: const Text(
                            'Créer mon compte',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: kSpaceXL),
                      
                      // Retour à la connexion
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous avez déjà un compte ? ",
                            style: TextStyle(color: Colors.grey.shade700, fontSize: kFontSizeBodySmall),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.goNamed('login');
                              }
                            },
                            child: Text(
                              "Se connecter",
                              style: TextStyle(
                                color: colorScheme.secondary,
                                fontSize: kFontSizeBodySmall,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kSpaceXXL),
                      // Séparateur "Ou s'inscrire avec"
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kSpaceL),
                            child: Text(
                              'Ou s\'inscrire avec',
                              style: TextStyle(
                                fontSize: kFontSizeBodySmall,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: kSpaceL),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // TODO: inscription Google
                              },
                              icon: Image.asset(
                                'assets/icon/google.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const FaIcon(FontAwesomeIcons.google, size: 20, color: Color(0xFF4285F4)),
                              ),
                              label: const Text('Google'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey.shade800,
                                side: BorderSide(color: Colors.grey.shade400),
                                padding: const EdgeInsets.symmetric(vertical: kSpaceL),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadiusM),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: kSpaceL),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // TODO: inscription Facebook
                              },
                              icon: const FaIcon(FontAwesomeIcons.facebook, size: 20, color: Color(0xFF1877F2)),
                              label: const Text('Facebook'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey.shade800,
                                side: BorderSide(color: Colors.grey.shade400),
                                padding: const EdgeInsets.symmetric(vertical: kSpaceL),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadiusM),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom + kSpaceXL),
                        ],
                      ),
                    ),
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

class _PasswordStrength {
  const _PasswordStrength({required this.label, required this.progress, required this.color});
  final String label;
  final double progress;
  final Color color;
}

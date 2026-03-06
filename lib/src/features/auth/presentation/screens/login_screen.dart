import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_design.dart';
import '../widgets/auth_background.dart';

/// Écran de connexion : fond tech, header titre+sous-titre (sans logo), carte blanche formulaire.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const AuthBackground(),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Header : bouton retour + titre + sous-titre (sans logo)
                SizedBox(
                  height: size.height * 0.22,
                  child: Stack(
                    children: [
                      // Align(
                      //   alignment: Alignment.topLeft,
                      //   child: IconButton(
                      //     onPressed: () {
                      //       if (context.canPop()) {
                      //         context.pop();
                      //       } else {
                      //         context.goNamed('onboarding');
                      //       }
                      //     },
                      //     icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 20),
                      //   ),
                      // ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kSpaceXL),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Connectez-vous à votre compte',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: kFontSizeDisplayLarge,
                                  fontWeight: FontWeight.w800,
                                  height: kLineHeightTight,
                                ),
                              ),
                              const SizedBox(height: kSpaceS),
                              Text(
                                'Connectez-vous pour accéder à votre espace participant.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
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
                // Carte blanche : formulaire uniquement
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(kSpaceXL, kSpaceXXL, kSpaceXL, 0),
                    decoration: BoxDecoration(
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
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(color: jiPrimary, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              labelText: 'Adresse email',
                              hintText: 'exemple@domaine.com',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
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
                              labelStyle: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          const SizedBox(height: kSpaceL),
                          TextField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(color: jiPrimary, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              hintText: '••••••••',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? FontAwesomeIcons.solidEyeSlash : FontAwesomeIcons.solidEye,
                                  color: colorScheme.secondary,
                                  size: kIconSizeMedium,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
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
                              labelStyle: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          const SizedBox(height: kSpaceS),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => context.pushNamed('forgot-password'),
                              style: TextButton.styleFrom(
                                foregroundColor: colorScheme.secondary,
                                padding: const EdgeInsets.symmetric(vertical: kSpaceM, horizontal: kSpaceS),
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: const Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: kSpaceL),
                          SizedBox(
                            height: kButtonHeightPrimary,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: appel API
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
                              child: const Text('Se connecter', style: AppTextStyles.button),
                            ),
                          ),
                          const SizedBox(height: kSpaceXXL),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pas encore de compte ? ",
                                style: TextStyle(color: Colors.grey.shade700, fontSize: kFontSizeBodySmall),
                              ),
                              GestureDetector(
                                onTap: () => context.pushNamed('register'),
                                child: Text(
                                  "S'inscrire",
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
                          // Séparateur "Ou se connecter avec"
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: kSpaceL),
                                child: Text(
                                  'Ou se connecter avec',
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
                                    // TODO: connexion Google
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
                                    // TODO: connexion Facebook
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

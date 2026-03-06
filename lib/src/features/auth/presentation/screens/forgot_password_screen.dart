import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_design.dart';
import '../widgets/auth_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                  height: size.height * 0.25,
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
                                'Récupération du mot de passe',
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
                                'Entrez votre email pour recevoir un lien de réinitialisation.',
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
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
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
                          const SizedBox(height: kSpaceXXL),
                          SizedBox(
                            height: kButtonHeightPrimary,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Un lien de réinitialisation a été envoyé à cette adresse.', style: TextStyle(color: Colors.white)),
                                    backgroundColor: colorScheme.secondary,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.goNamed('login');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.secondary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(kRadiusM),
                                ),
                              ),
                              child: const Text('Envoyer le lien', style: AppTextStyles.button),
                            ),
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

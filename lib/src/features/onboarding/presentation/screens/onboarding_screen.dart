import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_design.dart';

/// Onboarding qui présente l'application JI 2026
/// (rôle central, cibles et principaux modules).
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _lottieController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  final _pages = const [
    _OnboardingPageData(
      title: 'Bienvenue aux Journées Informatiques',
      description:
          "L'application mobile devient le cœur opérationnel des JI 2026. "
          "Inscrivez-vous, suivez le programme et vivez l'événement avant, pendant et après.",
      icon: Icons.rocket_launch_outlined,
    ),
    _OnboardingPageData(
      title: 'Pensée pour vous',
      description:
          "Étudiants, entrepreneurs, startups et sponsors : "
          "centralisez vos informations, mettez en avant vos projets et accédez rapidement aux activités.",
      icon: Icons.people_outline,
    ),
    _OnboardingPageData(
      title: 'Tout votre parcours, au même endroit',
      description:
          "Programme détaillé, agenda personnalisé, formations & masterclass, appel à projets, "
          "badges avec QR code et notifications officielles : tout est dans votre poche.",
      icon: Icons.event_available_outlined,
    ),
  ];

  void _goNext() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: kDurationShort),
        curve: Curves.easeOut,
      );
    } else {
      context.goNamed('login');
    }
  }

  void _goPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: kDurationShort),
        curve: Curves.easeOut,
      );
    }
  }

  void _skip() {
    context.goNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Fond animé Lottie (boucle infinie) en arrière-plan total
          Positioned.fill(
            child: Opacity(
              opacity: 1,
              child: Lottie.asset(
                'assets/json_lottie/technology.json',
                fit: BoxFit.cover,
                width: size.width,
                height: size.height,
                controller: _lottieController,
                onLoaded: (composition) {
                  _lottieController
                    ..duration = composition.duration
                    // On boucle sur les 80% premiers pour couper le blanc à la fin
                    ..repeat(min: 0.0, max: 0.8);
                },
              ),
            ),
          ),

          // Léger dégradé utilisant les couleurs du thème pour renforcer le contraste
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    jiPrimary.withOpacity(0.95),
                    jiPrimaryLight.withOpacity(0.9),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          
          // Contenu principal encadré par SafeArea pour la top/bottom bar du téléphone
          SafeArea(
            child: Column(
              children: [
                // Bouton "Passer" en haut à droite
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _skip,
                    child: const Text(
                      'Passer',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpaceXL,
                          vertical: kSpaceL,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  page.title,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: kSpaceL),
                                Text(
                                  page.description,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                                ),
                                const SizedBox(height: kSpaceL),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                _buildBottomBar(colorScheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: kDurationShort),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: kSpaceXS),
          height: kIndicatorSize,
          width: _currentIndex == index ? kIndicatorSizeActive : kIndicatorSize,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? colorScheme.secondary
                : Colors.white30,
            borderRadius: BorderRadius.circular(kRadiusM),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(ColorScheme colorScheme) {
    final isLast = _currentIndex == _pages.length - 1;

    if (!isLast) {
      // Pages intermédiaires : icônes FontAwesome pour revenir / avancer
      return Padding(
        padding: const EdgeInsets.fromLTRB(kSpaceL, kSpaceS, kSpaceL, kSpaceXL),
        child: Row(
          children: [
            IconButton(
              onPressed: _currentIndex == 0 ? null : _goPrevious,
              icon: const FaIcon(FontAwesomeIcons.arrowLeftLong),
              color: Colors.white,
            ),
            Expanded(
              child: _buildIndicators(colorScheme),
            ),
            IconButton(
              onPressed: _goNext,
              icon: const FaIcon(FontAwesomeIcons.arrowRightLong),
              color: Colors.white,
            ),
          ],
        ),
      );
    }

    // Dernière page : indicateurs + gros bouton "Commencer"
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSpaceXL, kSpaceS, kSpaceXL, kSpaceXL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicators(colorScheme),
          const SizedBox(height: kSpaceL),
          SizedBox(
            width: double.infinity,
            height: kButtonHeightPrimary,
            child: ElevatedButton(
              onPressed: _skip,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadiusL),
                ),
              ),
              child: const Text(
                'Commencer',
                style: AppTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}


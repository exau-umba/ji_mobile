import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_design.dart';

/// Page d'accueil : uniquement le banner (slides) + BottomNavigationBar avec Font Awesome.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  /// Chemins des images du banner (slides). Remplacer par vos assets ou URLs.
  static const List<String> _bannerSlides = [
    'assets/images/Gemini_Generated_Image_2y4cno2y4cno2y4c.png',
    'assets/images/Gemini_Generated_Image_chewkfchewkfchew.png',
    'assets/images/Gemini_Generated_Image_dov5l5dov5l5dov5.png',
    'assets/images/Gemini_Generated_Image_lhhuw5lhhuw5lhhu.png',
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      final next = (_currentBannerIndex + 1) % _bannerSlides.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Banner : slides (carousel) 16/9
        LayoutBuilder(
          builder: (context, constraints) {
            final width =
                constraints.maxWidth - (kScreenPaddingHorizontal * 2);
            final height = width * 5 / 9;
            return SizedBox(
              height: height,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: _bannerController,
                    onPageChanged: (index) =>
                        setState(() => _currentBannerIndex = index),
                    itemCount: _bannerSlides.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: AppInsets.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(kRadiusL),
                          child: Image.asset(
                            _bannerSlides[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [jiPrimary, jiPrimaryLight],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.white54,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: kSpaceM),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _bannerSlides.length,
                        (index) => AnimatedContainer(
                          duration:
                              const Duration(milliseconds: kDurationShort),
                          margin: const EdgeInsets.symmetric(
                              horizontal: kSpaceXS),
                          height: kIndicatorSize,
                          width: _currentBannerIndex == index
                              ? kIndicatorSizeActive
                              : kIndicatorSize,
                          decoration: BoxDecoration(
                            color: _currentBannerIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Contenu vide en dessous (plus de cartes ni grille)
        const Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}

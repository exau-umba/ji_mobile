import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import '../theme/app_design.dart';
import 'ji_bottom_navigation_bar.dart';

/// Shell principal qui contient l'AppBar et le BottomNavigationBar
/// et affiche le contenu de la page active en tant que `child`.
class MainShell extends StatelessWidget {
  final Widget child;
  final int notificationCount;
  final String location;

  const MainShell({
    super.key,
    required this.child,
    required this.location,
    this.notificationCount = 3,
  });

  int _indexFromLocation(String location) {
    final path = Uri.parse(location).path;
    if (path.startsWith('/agenda')) return 1;
    if (path.startsWith('/annonces')) return 2;
    if (path.startsWith('/profile')) return 3;
    // TODO: quand l'agenda et le profil auront leurs routes dédiées
    // if (location.startsWith('/agenda')) return 1;
    // if (location.startsWith('/profil')) return 3;
    return 0; // dashboard par défaut
  }

  String _titleFromLocation(String location) {
    final uri = Uri.parse(location);
    if (uri.path.contains('/comments')) {
      final annonceTitle = uri.queryParameters['title'];
      if (annonceTitle != null && annonceTitle.trim().isNotEmpty) {
        return annonceTitle;
      }
      return 'Commentaires';
    }
    if (uri.path.startsWith('/settings/change-password')) {
      return 'Changer le mot de passe';
    }
    if (uri.path.startsWith('/settings/about')) return 'À propos';
    if (uri.path.startsWith('/profile/edit')) return 'Modifier mon profil';
    if (uri.path.startsWith('/settings')) return 'Paramètres';
    if (uri.path.startsWith('/notifications')) return 'Notifications';
    if (uri.path.startsWith('/profile/qr-badge')) return 'Mon badge QR';
    if (uri.path.startsWith('/agenda')) return 'Agenda';
    if (uri.path.startsWith('/annonces')) return 'Annonces';
    if (uri.path.startsWith('/profile')) return 'Profil';
    return 'Journées Informatiques';
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed('dashboard');
        break;
      case 1:
        context.goNamed('agenda');
        break;
      case 2:
        context.goNamed('annonces');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromLocation(location);
    final title = _titleFromLocation(location);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: jiPrimary,
            fontWeight: FontWeight.w600,
            fontSize: kFontSizeTitleMedium,
          ),
        ),
        leading: _buildLeading(context, location),
        leadingWidth: kLogoHeightAppBar + (kSpaceS * 2),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              isLabelVisible: notificationCount > 0,
              label: Text('$notificationCount'),
              child: const FaIcon(
                FontAwesomeIcons.bell,
                color: jiPrimary,
                size: kIconSizeMedium,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/icon/JI_MINI_LOGO.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.92)),
          ),
          SafeArea(child: child),
        ],
      ),
      bottomNavigationBar: JiBottomNavigationBar(
        currentIndex: currentIndex,
        notificationCount: notificationCount,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }
}

Widget _buildLeading(BuildContext context, String location) {
  final path = Uri.parse(location).path;
  final isRoot =
      path == '/dashboard' ||
      path == '/agenda' ||
      path == '/annonces' ||
      path == '/profile' ||
      path == '/';
  if (!isRoot) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: jiPrimary),
      onPressed: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.goNamed('dashboard');
        }
      },
    );
  }
  return Padding(
    padding: const EdgeInsets.all(kSpaceS),
    child: Image.asset(
      'assets/icon/JI_MINI_LOGO.png',
      height: kLogoHeightAppBar,
      fit: BoxFit.contain,
    ),
  );
}


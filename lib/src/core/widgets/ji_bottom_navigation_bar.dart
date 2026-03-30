import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/app_theme.dart';

class JiBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final int notificationCount;
  final ValueChanged<int>? onTap;

  const JiBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.notificationCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: jiSecondary,
      unselectedItemColor: jiPrimary.withOpacity(0.5),
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: currentIndex == 0 ? FaIcon(FontAwesomeIcons.solidHouse, size: 20) : FaIcon(FontAwesomeIcons.house, size: 20),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 1 ? FaIcon(FontAwesomeIcons.solidCalendarDays, size: 20) : FaIcon(FontAwesomeIcons.calendarDays, size: 20),
          label: 'Agenda',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            isLabelVisible: notificationCount > 0,
            label: Text('$notificationCount'),
            child: currentIndex == 2 ? FaIcon(FontAwesomeIcons.bullhorn, size: 20) : FaIcon(FontAwesomeIcons.bullhorn,size: 20,),
          ),
          label: 'Annonces',
        ),
         BottomNavigationBarItem(
          icon: currentIndex == 3 ? FaIcon(FontAwesomeIcons.solidUser, size: 20) : FaIcon(FontAwesomeIcons.user, size: 20),
          label: 'Profil',
        ),
      ],
    );
  }
}


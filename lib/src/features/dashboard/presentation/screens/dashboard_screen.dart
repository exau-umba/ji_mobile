import 'package:flutter/material.dart';

/// Dashboard principal de l’app mobile.
/// Visuel inspiré de la maquette rouge (carte de compte + tuiles de services).
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bandeau haut type "carte" avec stats principales
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFFB31217), Color(0xFFE52D27)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bonjour,',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Participant JI 2026',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Vos inscriptions',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Formations: 0  ·  Projets: 0  ·  Badge: 0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Actions rapides',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          children: const [
                            _DashboardTile(
                              icon: Icons.event_available_outlined,
                              label: 'Programme',
                            ),
                            _DashboardTile(
                              icon: Icons.school_outlined,
                              label: 'Formations',
                            ),
                            _DashboardTile(
                              icon: Icons.lightbulb_outline,
                              label: 'Appel à projets',
                            ),
                            _DashboardTile(
                              icon: Icons.badge_outlined,
                              label: 'Mes badges',
                            ),
                            _DashboardTile(
                              icon: Icons.chat_bubble_outline,
                              label: 'Annonces',
                            ),
                            _DashboardTile(
                              icon: Icons.person_outline,
                              label: 'Profil',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note_outlined),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DashboardTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0066FF),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


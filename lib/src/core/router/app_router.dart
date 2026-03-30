import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/annonces/presentation/screens/annonces_list_screen.dart';
import '../../features/annonces/presentation/screens/annonce_detail_screen.dart';
import '../../features/annonces/presentation/screens/annonce_comments_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/qr_badge_screen.dart';
import '../widgets/main_shell.dart';

/// Router principal de l'application mobile.
/// Splash → Onboarding → Login/Register → Dashboard
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) =>
          MainShell(child: child, location: state.uri.toString()),
      routes: [
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/annonces',
          name: 'annonces',
          builder: (context, state) => const AnnoncesListScreen(),
        ),
        GoRoute(
          path: '/annonces/:id',
          name: 'annonce-detail',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return AnnonceDetailScreen(annonceId: id);
          },
        ),
        GoRoute(
          path: '/annonces/:id/comments',
          name: 'annonce-comments',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return AnnonceCommentsScreen(annonceId: id);
          },
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/profile/qr-badge',
          name: 'profile-qr-badge',
          builder: (context, state) => const QrBadgeScreen(),
        ),
      ],
    ),
  ],
);


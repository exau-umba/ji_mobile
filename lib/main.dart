import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/MonApplication.dart';
import 'src/features/auth/presentation/bloc/auth_bloc.dart';
import 'src/features/auth/presentation/bloc/auth_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JiMobileApp());
}

/// Point d'entrée global de l'application JI Mobile.
/// Injecte les BLoC racine puis délègue l'UI à `MonApplication`.
class JiMobileApp extends StatelessWidget {
  const JiMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(const AuthCheckRequested()),
        ),
      ],
      child: const MonApplication(),
    );
  }
}
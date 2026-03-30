import 'package:flutter/material.dart';
// import 'package:flutter_skill/flutter_skill.dart';
import '../src/core/theme/app_theme.dart';
import '../src/core/router/app_router.dart';

/// Application principale (MaterialApp + thème + navigation).
class MonApplication extends StatelessWidget {

  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final router = appRouter;

    return MaterialApp.router(
      title: 'JI 2026',
      debugShowCheckedModeBanner: false,
      theme: buildJiTheme(Brightness.light),
      themeMode: ThemeMode.light,
      darkTheme: buildJiTheme(Brightness.dark),
      routerConfig: router,
    );
  }
}
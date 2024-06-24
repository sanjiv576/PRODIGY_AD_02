import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_routes.dart';
import 'state/app_theme_state.dart';
import 'themes/app_theme.dart';

class AppView extends ConsumerWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(isDarkThemeProvider)
          ? AppThemes.appDarkTheme()
          : AppThemes.appLightTheme(),
      initialRoute: AppRoutes.splashRoute,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}

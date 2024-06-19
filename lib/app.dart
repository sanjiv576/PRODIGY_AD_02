import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_routes.dart';
import 'themes/app_theme.dart';
import 'view/home_view.dart';

// class AppView extends StatelessWidget {
//   const AppView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: AppThemes.appDarkTheme(),
//       initialRoute: AppRoutes.introRoute,
//       routes: AppRoutes.getAppRoutes(),
//     );
//   }
// }

class AppView extends ConsumerWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ref.watch(isDarkThemeProvider)
          ? AppThemes.appDarkTheme()
          : AppThemes.appLightTheme(),
      initialRoute: AppRoutes.introRoute,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}

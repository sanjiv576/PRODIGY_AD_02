import 'package:flutter/material.dart';
import 'router/app_routes.dart';
import 'themes/app_theme.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appDarkTheme(),
      initialRoute: AppRoutes.homeRoute,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}

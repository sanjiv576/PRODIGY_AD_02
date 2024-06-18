import 'package:todolist/view/intro_view.dart';

import '../view/home_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String homeRoute = '/';
  static const String introRoute = '/intro';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      introRoute: (context) => const IntroView(),
    };
  }
}

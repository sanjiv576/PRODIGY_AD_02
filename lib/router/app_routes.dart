import '../view/home_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String homeRoute = '/';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
    };
  }
}

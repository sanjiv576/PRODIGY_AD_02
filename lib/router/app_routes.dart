import '../view/create_new_list_view.dart';
import '../view/home_view.dart';
import '../view/intro_view.dart';
import '../view/splash_view.dart';
import '../view/update_list_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String homeRoute = '/';
  static const String introRoute = '/intro';
  static const String createNewListRoute = '/newList';
  static const String updateListView = '/updateList';
  static const String splashRoute = '/splash';

  static getAppRoutes() {
    return {
      homeRoute: (context) => const HomeView(),
      introRoute: (context) => const IntroView(),
      createNewListRoute: (context) => const CreateNewListView(),
      updateListView: (context) => const UpdateListView(),
      splashRoute: (context) => const SplashView(),
    };
  }
}

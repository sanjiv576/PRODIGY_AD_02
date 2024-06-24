import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider((ref) => UserSharedPrefs());

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  Future<void> setAppLaunch(bool? isAppLaunch) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences.setBool('isAppLaunch', isAppLaunch ?? false);
  }

  Future<bool?> isAppLaunch() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('isAppLaunch');
  }

// for app theme

  Future<void> setAppTheme(bool? isDarkValue) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences.setBool('isDark', isDarkValue ?? false);
  }

  Future<bool?> getAppTheme() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('isDark');
  }

  // for showing tutorial
  Future<void> setTutorial(bool? isTutorialShown) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    _sharedPreferences.setBool('isTutorialShown', isTutorialShown ?? false);
  }

  Future<bool?> getTutorial() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('isTutorialShown');
  }
}

import '../shared_prefs/user_shared_prefs.dart';

class AppLaunch {
  static Future<bool> isAppLauchAlreaddy() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();
    return await userSharedPrefs.isAppLaunch() ?? false;
  }

  static setAppLaunch(bool isLaunch) async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();

    await userSharedPrefs.setAppLaunch(isLaunch);
  }
}

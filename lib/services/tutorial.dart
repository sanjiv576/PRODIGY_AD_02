
import '../shared_prefs/user_shared_prefs.dart';

class Tutorial {
  static Future<bool> isTutorialAlreadyShown() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();
    return await userSharedPrefs.getTutorial() ?? false;
  }

  static setTutorialValue(bool isShown) async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();

    await userSharedPrefs.setTutorial(isShown);
  }

  
}

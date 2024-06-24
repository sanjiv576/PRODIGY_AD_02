import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared_prefs/user_shared_prefs.dart';

class AppThemeState extends StateNotifier<bool> {
  UserSharedPrefs userSharedPrefs;

  AppThemeState(this.userSharedPrefs) : super(false) {
    onInit();
  }

  onInit() async {
    bool? isDarkValue = await userSharedPrefs.getAppTheme();
    state = isDarkValue ?? false;
  }

  updateTheme(bool isDarkValue) async {
    await userSharedPrefs.setAppTheme(isDarkValue);
    state = isDarkValue;
  }
}

final isDarkThemeProvider = StateNotifierProvider<AppThemeState, bool>(
    (ref) => AppThemeState(ref.watch(userSharedPrefsProvider)));

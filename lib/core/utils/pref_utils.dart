//ignore: unused_import
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setIsDarkMode(bool value) {
    return _sharedPreferences!.setBool('isDarkTheme', value);
  }

  bool getIsDarkMode() {
    try {
      return _sharedPreferences!.getBool('isDarkTheme')!;
    } catch (e) {
      return false;
    }
  }
}

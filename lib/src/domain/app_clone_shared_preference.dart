/*
import 'package:shared_preferences/shared_preferences.dart';

class SharedAppPreference {
  static SharedAppPreference? _instance;
  SharedPreferences? _prefs;

  //private constructor

  //factory constructor returning the instance of the Shared Preference
  //returns new instance if no existing instance else returns existing instance
  factory SharedAppPreference.instance() {
    return SharedAppPreference(_prefs:SharedPreferences.getInstance());
  }

  Future<void> addSharedPreference(String key, dynamic value) async {
    if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is List<String>) {
      await _prefs?.setStringList(key, value);
    } else {
      throw Exception('Invalid value type');
    }
  }

  dynamic getSharedPreference(String key) {
    return _prefs?.get(key);
  }
}
*/

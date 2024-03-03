import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_model.dart';

class UserDefaults {
  static SharedPreferences? sharedPreferences;

  static Future<bool?> clearAll() async {
    return await sharedPreferences?.clear() ?? false;
  }

  static Future<SharedPreferences> getPref() async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    return sharedPreferences!;
  }

  setBoolValue(String key, bool value) async {
    final SharedPreferences sharedPreferences = await getPref();
    sharedPreferences.setBool(key, value);
  }

  setString(String key, String value) async {
    final SharedPreferences sharedPreferences = await getPref();
    sharedPreferences.setString(key, value);
  }

  bool getBoolValue(String key, bool defaultValue) {
    if (sharedPreferences != null) {
      return sharedPreferences!.containsKey(key)
          ? sharedPreferences!.getBool(key)!
          : defaultValue;
    }
    return defaultValue;
  }

  String getStringValue(String key, String defaultValue) {
    if (sharedPreferences != null) {
      return sharedPreferences!.containsKey(key)
          ? sharedPreferences!.getString(key)!
          : defaultValue;
    }

    return defaultValue;
  }

  static void setIntValue(String key, int value) {
    final SharedPreferences sharedPreferences = UserDefaults.sharedPreferences!;

    sharedPreferences.setInt(key, value);
  }

  static int getIntValue(String key, int defaultValue) {
    final SharedPreferences sharedPreferences = UserDefaults.sharedPreferences!;

    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  static saveUserSession(AuthModel userModel) async {
    String user = json.encode(userModel.toJson());

    return await getPref().then((value) => value..setString('AuthModel', user));
  }

  static AuthModel? getUserSession() {
    AuthModel? user;
    if (sharedPreferences!.getString('AuthModel') != null) {
      Map<String, dynamic> json =
          jsonDecode(sharedPreferences!.getString('AuthModel')!);
      user = AuthModel.fromJson(json);
    }
    return user;
  }
}

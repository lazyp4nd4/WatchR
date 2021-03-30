import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions {
  static String sharedPreferencesUIDKey = "USERuid";
  static Future<bool> saveUserUid(String uid) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(sharedPreferencesUIDKey, uid);
      return true;
    } catch (e) {
      print("error saving uid to shared preferences");
      return false;
    }
  }

  static Future<String> getUserUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesUIDKey);
  }

  // name

  static String sharedPreferencesNameKey = "USERname";
  static Future<bool> saveUserName(String name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(sharedPreferencesNameKey, name);
      return true;
    } catch (e) {
      print("error saving name to shared preferences");
      return false;
    }
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesNameKey);
  }

  // phone number

  static String sharedPreferencesPNKey = "USERphone";
  static Future<bool> saveUserPN(String pn) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(sharedPreferencesPNKey, pn);
      return true;
    } catch (e) {
      print("error saving pn to shared preferences");
      return false;
    }
  }

  static Future<String> getUserPN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferencesPNKey);
  }
}

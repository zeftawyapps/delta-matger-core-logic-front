import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Common Keys
  static const String _keyToken = "auth_token";
  static const String _keyUserData = "user_data";
  static const String _keyLastUser = "last_username";
  static const String _keyLastPass = "last_password";

  // Token Management
  static Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  static String? getToken() {
    return _prefs.getString(_keyToken);
  }

  static Future<void> clearToken() async {
    await _prefs.remove(_keyToken);
  }

  // Generic Data Management
  static Future<void> saveData(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getData(String key) {
    return _prefs.getString(key);
  }

  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  // Credentials Persistence
  static Future<void> saveLastCredentials(String user, String pass) async {
    await _prefs.setString(_keyLastUser, user);
    await _prefs.setString(_keyLastPass, pass);
  }

  static Map<String, String> getLastCredentials() {
    return {
      "username": _prefs.getString(_keyLastUser) ?? "",
      "password": _prefs.getString(_keyLastPass) ?? "",
    };
  }

  // Clear All
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}

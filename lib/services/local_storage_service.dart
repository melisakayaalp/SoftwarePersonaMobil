import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _usernameKey = 'username';

  Future<void> saveUsername(String username) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, username);
  }

  Future<String?> getUsername() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }

  Future<void> clearUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(_usernameKey);
  }
}
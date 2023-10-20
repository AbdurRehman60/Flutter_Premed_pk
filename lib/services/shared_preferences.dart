import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AppPreferences {
  static const String _userKey = 'user_data';

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    return prefs.setString(_userKey, userJson);
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    } else {
      return null;
    }
  }
}

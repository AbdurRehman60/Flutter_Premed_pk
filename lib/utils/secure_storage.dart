// import 'package:apag_flutter_app/models/user_role.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  final secStorage = FlutterSecureStorage();

  Future<void> saveRefreshToken(String refreshToken) async {
    await secStorage.write(key: "refreshToken", value: refreshToken);
  }

  Future<String> getRefreshToken() async {
    var refreshToken = await secStorage.read(key: "refreshToken") ?? '';
    return refreshToken;
  }

  Future<void> removeRefreshToken() async {
    await secStorage.deleteAll();
  }
}

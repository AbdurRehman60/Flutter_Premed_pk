import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  factory UserProvider() => _instance;

  UserProvider._internal();
  static final UserProvider _instance = UserProvider._internal();

  void notify() {
    notifyListeners();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notify();
  }

  String getUserName() {
    return _user?.fullName ?? '';
  }

  String getEmail() {
    return _user?.userName ?? '';
  }

  int getCoins() {
    return _user?.coins ?? 0;
  }
}

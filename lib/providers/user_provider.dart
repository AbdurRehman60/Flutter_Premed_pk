import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  static final UserProvider _instance = UserProvider._internal();
  factory UserProvider() => _instance;

  UserProvider._internal();

  notify() {
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

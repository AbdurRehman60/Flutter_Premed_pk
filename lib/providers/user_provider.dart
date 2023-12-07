import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final List<CameraDescription> cameras;
  UserProvider(this.cameras);
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners(); // Notify listeners when the user is set.
  }

  String? getUserName() {
    return _user?.userName;
  }
}

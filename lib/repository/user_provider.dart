import 'package:premedpk_mobile_app/export.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late User _user;
  User get user => _user;

  void setUser(User user) {
    _user = user;
  }

  String getuserName() {
    return _user.userName.toString();
  }
}

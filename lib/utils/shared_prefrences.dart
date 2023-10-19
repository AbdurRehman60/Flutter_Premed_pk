import 'package:shared_preferences/shared_preferences.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import '../models/user_model.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.setString('dsrID', user.dsrID);
    // prefs.setString('name', user.name);
    // prefs.setString('mobileNumber', user.mobileNumber);

    // prefs.setInt('userRoleID', user.userRole.userRoleId);
    // prefs.setString('userRole', user.userRole.userRole);

    // prefs.setString('accessToken', user.accessToken);
    // prefs.setString('refreshToken', user.refreshToken);

    return prefs.commit();
  }

  Future<void> saveAttendanceID(int attendanceID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('attendanceID', attendanceID);
  }

  //TO DO DELETE ATTENDANCE ID

  Future<void> initNetworkCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('netwrokChecked', true);
  }

  Future<void> initAttendanceMarked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('attendanceMarked', true);
  }

  Future<void> initPJPFetched() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('pjpFetched', true);
  }

  Future<Map<String, dynamic>> fetchPJPDetails() async {
    var result;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool netwrokCheck = prefs.getBool("netwrokChecked") ?? false;
    bool attendanceCheck = prefs.getBool("attendanceMarked") ?? false;
    bool pjpCheck = prefs.getBool("pjpFetched") ?? false;

    result = {
      'netwrokCheck': netwrokCheck,
      'attendanceCheck': attendanceCheck,
      'pjpCheck': pjpCheck,
    };

    return result;
  }

  // Future<User> getUser() async {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  // String dsrID = prefs.getString("dsrID") ?? '';
  // String name = prefs.getString("name") ?? '';
  // String mobileNumber = prefs.getString("mobileNumber") ?? '';
  // String accessToken = prefs.getString("accessToken") ?? '';

  // String userRole = prefs.getString("userRole") ?? '';
  // int userRoleID = prefs.getInt("userRoleID") ?? -1;

  // return User(
  // dsrID: dsrID,
  // name: name,
  // mobileNumber: mobileNumber,
  // accessToken: accessToken,
  // userRole: UserRole(userRole: userRole, userRoleId: userRoleID),
  // );
}

Future<bool> getPJPStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status = prefs.getBool("pjpFetched") ?? false;
  return status;
}

void removeUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove('dsrID');
  prefs.remove('name');
  prefs.remove('mobileNumber');
  prefs.remove('accessToken');
  prefs.remove('userRole');
  prefs.remove('accessToken');
  prefs.remove('userRoleID');
  prefs.remove('attendanceID');
  deleteSystemStartTime();
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("accessToken") ?? '';
  return token;
}

Future<void> updateToken(String newToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String accessToken = prefs.getString("accessToken") ?? '';
  // print('Old access token ${prefs.getString("accessToken") ?? ''}');

  prefs.setString('accessToken', newToken);
  prefs.reload();
  // print('new access token ${prefs.getString("accessToken") ?? ''}');
}

// Future<void> saveSystemStartTime(DateTime startTime) async {
// final SharedPreferences prefs = await SharedPreferences.getInstance();
// print('setting starttime in SP');
// prefs.setString(
// 'startTime',
// formatDateTime(startTime),
// );

// print('object + ${formatDateTime(startTime)}');
// }

Future<void> deleteSystemStartTime() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('startTime');
}

Future<void> deletePJPDetails() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('startTime');
  prefs.setBool('attendanceMarked', false);
  prefs.setBool('pjpFetched', false);
}
// }

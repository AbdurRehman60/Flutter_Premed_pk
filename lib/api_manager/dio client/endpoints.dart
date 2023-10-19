class Endpoints {
  Endpoints._();
  //Ports
  static const String serverPort = "3380";
  static const String socketPort = "3390";

  // base url
  // static const String baseUrl = "http://192.168.10.9";
  static const String baseUrl = "http://43.245.131.203";

  //specific URLs
  static const String serverURL = "${baseUrl}:${serverPort}";
  static const String socketURL = "${baseUrl}:${socketPort}";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String checkNetwork = '/attendance/checkNetwork';
  static const String markAttendance = '/attendance/checkin';
  static const String newAccessToken = '/auth/tokens';
  static const String fetchPJP = '/pjp/fetchpjp';
  static const String submitPJP = '/pjp/submitpjp';
}

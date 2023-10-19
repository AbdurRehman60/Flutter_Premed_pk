class Endpoints {
  Endpoints._();
  //Ports
  static const String serverPort = "4002";

  // base url
  // static const String baseUrl = "http://192.168.10.9";
  static const String baseUrl = "http://192.168.10.6";

  //specific URLs
  static const String serverURL = "${baseUrl}:${serverPort}";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const String login = '/login';
  static const String logout = '/auth/logout';
  static const String checkNetwork = '/attendance/checkNetwork';
  static const String markAttendance = '/attendance/checkin';
  static const String newAccessToken = '/auth/tokens';
  static const String fetchPJP = '/pjp/fetchpjp';
  static const String submitPJP = '/pjp/submitpjp';
}

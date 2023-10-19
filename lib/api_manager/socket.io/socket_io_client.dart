// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// import '../dio client/endpoints.dart';

// class ClientSocket {
//   static final ClientSocket _socket = ClientSocket._internal();

//   factory ClientSocket() {
//     return _socket;
//   }

//   ClientSocket._internal();

//   late IO.Socket socket;
//   List<Map<String, dynamic>> pendingLocations = [];

//   String socketURL =
//       '${Endpoints.socketURL}?User_ID='; //http://192.168.10.6:90?User_ID=48

//   // String accessToken =
//   //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2ODQ5MzE2MDMsImV4cCI6MTcxNjQ4OTIwMywiYXVkIjpbIjIiXSwiaXNzIjoiQVBBRyBCYWNrZW5kIFNlcnZlciJ9.YzDDEdlbQ9hk-W8kXaxHm97C3VaiiRmgtpnqZPLdbMc";

//   bool get isConnected => socket.connected;

//   void initSocket() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String accessToken = prefs.getString("accessToken") ?? '';
//     String userID = prefs.getString("dsrID") ?? '';

//     // String userID = '48';
//     socket = IO.io(socketURL + userID, <String, dynamic>{
//       'autoConnect': false,
//       'transports': ['websocket'],
//       'extraHeaders': {'Authorization': 'bearer $accessToken'},
//       // 'reconnection': true,
//       // 'reconnectionAttempts': 5,
//       // 'reconnectionDelay': 1000,
//       // 'randomizationFactor': 0.5,
//       // 'connectTimeout': 5000
//     });

//     socket.clearListeners();

//     socket.connect();
//     socket.onConnect((_) {
//       printdebug();
//     });

//     // socket.on('timeout', (_) {
//     //   print('Connection timeout');
//     //   socket.close();
//     //   // Perform additional actions as needed
//     // });

//     // socket.onReconnect((_) {
//     //   print('Reconnected');
//     //   // Perform any necessary actions after successful reconnection
//     // });

//     // socket.onConnectTimeout((_) {
//     //   print('Connection timeout');
//     // });

//     socket.onDisconnect((_) => print('Connection Disconnected!'));
//     socket.onConnectError((err) => print(err));
//     socket.onError((err) => print(err));
//   }

//   void connectSocket() {
//     if (!isConnected) {
//       socket.connect();
//     }
//   }

//   void disconnectSocket() {
//     socket.disconnect();
//     socket.clearListeners(); // Clean up event listeners
//   }

//   void closeSocket() {
//     disconnectSocket();
//   }

//   void sendLocation(Map<String, dynamic> coords) {
//     if (isConnected) {
//       _emitLocationData(coords);
//     } else {
//       pendingLocations.add(coords);
//       connectSocket();
//       sendPendingLocation();
//     }
//   }

//   void _emitLocationData(Map<String, dynamic> coords) {
//     final locationData = _getLocationData();
//     socket.emit('position-change', coords);
//   }

//   Map<String, dynamic> _getLocationData() {
//     return {
//       "User_ID": "48",
//       "Coordinates": {
//         "Latitude": 24.875309,
//         "Longitude": 67.054028,
//         "Time_Stamp": "2022-05-24T11:02:29.521Z",
//         "Battery_Percentage": 69,
//         "Elapsed_Time": 123,
//         "Activity": "walk"
//       }
//     };
//   }

//   void sendPendingLocation() {
//     if (pendingLocations.isNotEmpty) {
//       for (var location in pendingLocations) {
//         socket.emit('position-change', location);
//       }
//       pendingLocations.clear();
//     }
//   }

//   printdebug() {
//     print('Connection established!');
//     print('Current Socket ID: ${socket.id ?? 'no scoket opened'}');
//   }
// }

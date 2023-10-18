class User {
  int pjpShopId;
  String date;
  bool visited;
  double? visitedLatitude;
  double? visitedLongitude;
  double? distance;
  String? time;
  String? systemTime;
  bool skipVisit;
  String? skipReason;
  String? address;
  bool isRecovery;
  String dsrId;
  Shop shop;

  User({
    required this.pjpShopId,
    required this.date,
    required this.visited,
    required this.visitedLatitude,
    required this.visitedLongitude,
    required this.distance,
    required this.time,
    required this.systemTime,
    required this.skipVisit,
    required this.skipReason,
    required this.address,
    required this.isRecovery,
    required this.dsrId,
    required this.shop,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      pjpShopId: responseData['PJP_Shop_ID'],
      date: responseData['Date'],
      visited: responseData['Visited'],
      visitedLatitude: responseData['Visited_Latitude'],
      visitedLongitude: responseData['Visited_Longitude'],
      distance: responseData['Distance'],
      time: responseData['Time'],
      systemTime: responseData['System_Time'],
      skipVisit: responseData['Skip_Visit'],
      skipReason: responseData['Skip_Reason'],
      address: responseData['Address'],
      isRecovery: responseData['IsRecovery'],
      dsrId: responseData['User_ID'],
      shop: Shop.fromJson(responseData['Shop']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PJP_Shop_ID'] = pjpShopId;
    _data['Date'] = date;
    _data['Visited'] = visited;
    _data['Visited_Latitude'] = visitedLatitude;
    _data['Visited_Longitude'] = visitedLongitude;
    _data['Distance'] = distance;
    _data['Time'] = time;
    _data['System_Time'] = systemTime;
    _data['Skip_Visit'] = skipVisit;
    _data['Skip_Reason'] = skipReason;
    _data['Address'] = address;
    _data['IsRecovery'] = isRecovery;
    _data['User_ID'] = dsrId;
    _data['Shop'] = shop.toJson();
    return _data;
  }
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';

enum Status {
  Init,
  Sending,
  Error,
}

class AskAnExpertProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _doubtUploadStatus = Status.Init;

  Status get doubtUploadStatus => _doubtUploadStatus;

  set doubtUploadStatus(Status value) {
    _doubtUploadStatus = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> askanexpert({
    required String username,
    required String description,
    required String subject,
    required String topic,
    required String resource,
    required String testImage,
  }) async {
    var result;
    final Map<String, dynamic> askanexpertData = {
      "username": "ddd@gmail.com",
      "description": description,
      "subject": subject,
      "topic": topic,
      "resource": resource,
      "testImage": testImage,
    };

    _doubtUploadStatus = Status.Sending;
    print('Hello');
    notify();
    try {
      Response response = await _client.post(
        Endpoints.DoubtUpload, // Update to match your API endpoint
        data: askanexpertData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        if (responseData["success"]) {
          result = {
            'status': true,
            'message': responseData["message"],
          };
        } else {
          result = {
            'status': false,
            'message': responseData["message"],
          };
        }
      } else {
        _doubtUploadStatus = Status.Error;
        notify();

        // Returning results
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      _doubtUploadStatus = Status.Init;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/base64_convertor.dart';

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

  String _selectedResource = '';
  String get selectedResource => _selectedResource;
  set selectedResource(String value) {
    _selectedResource = value;
    notify();
  }

  String _selectedSubject = '';
  String get selectedSubject => _selectedSubject;
  set selectedSubject(String value) {
    _selectedSubject = value;
    notify();
  }

  String _selectedTopic = '';
  String get selectedTopic => _selectedTopic;
  set selectedTopic(String value) {
    _selectedTopic = value;
    notify();
  }

  File? _uploadedImage;
  File? get uploadedImage => _uploadedImage;

  set uploadedImage(File? value) {
    _uploadedImage = value;
    notify();
  }

  notify() {
    notifyListeners();
  }

  void resetState() {
    _doubtUploadStatus = Status.Init;
    _selectedResource = '';
    _selectedSubject = '';
    _selectedTopic = '';
    _uploadedImage = null;

    notify();
  }

  Future<Map<String, dynamic>> uploadDoubt({
    required String email,
    required String description,
    required String subject,
    required String topic,
    required String resource,
    required File testImage,
  }) async {
    var result;
    final Map<String, dynamic> askAnExpertData = {
      "username": email,
      "description": description,
      "subject": subject,
      "topic": topic,
      "resource": resource,
      "testImage": await imageToDataUri(testImage, "image/jpeg"),
    };

    _doubtUploadStatus = Status.Sending;

    notify();
    try {
      Response response = await _client.post(
        Endpoints.DoubtUpload, // Update to match your API endpoint
        data: askAnExpertData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        if (responseData["success"]) {
          result = {
            'status': true,
            'message': responseData["message"],
          };
          resetState();
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
        'message': e.response?.data['message'],
      };
    }
    return result;
  }
}

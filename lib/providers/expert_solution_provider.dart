// ignore_for_file: constant_identifier_names, unnecessary_getters_setters, deprecated_member_use

import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/base64_convertor.dart';

enum Status {
  Init,
  Sending,
  Error,
  Success,
}

class AskAnExpertProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _doubtUploadStatus = Status.Init;

  Status get doubtUploadStatus => _doubtUploadStatus;

  set doubtUploadStatus(Status value) {
    _doubtUploadStatus = value;
  }

  Status _fetchDoubtsStatus = Status.Init;

  Status get fetchDoubtsStatus => _fetchDoubtsStatus;

  set fetchDoubtsStatus(Status value) {
    _fetchDoubtsStatus = value;
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

  List<Doubt> _solvedDoubts = [];
  List<Doubt> get solvedDoubts => _solvedDoubts;
  set solvedDoubts(List<Doubt> value) {
    _solvedDoubts = value;
    notify();
  }

  void notify() {
    notifyListeners();
  }

  void resetState(UplaodImageProvider uploadImageProvider) {
    _doubtUploadStatus = Status.Init;
    _selectedResource = '';
    _selectedSubject = '';
    _selectedTopic = '';
    uploadImageProvider.initToNull();

    notify();
  }

  Future<Map<String, dynamic>> uploadDoubt({
    required String description,
    required String subject,
    required String topic,
    required String resource,
    required File testImage,
  }) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> askAnExpertData = {
      "username": UserProvider().getEmail(),
      "description": description,
      "subject": subject,
      "topic": topic,
      "resource": resource,
      "testImage": await imageToDataUri(testImage, "image/jpeg"),
    };

    _doubtUploadStatus = Status.Sending;

    notify();
    try {
      final Response response = await _client.post(
        Endpoints.DoubtUpload,
        data: askAnExpertData,
      );
      print(response);

      if (response.statusCode == 200) {
        print('object${response}');
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
      _doubtUploadStatus = Status.Error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    _doubtUploadStatus = Status.Init;
    return result;
  }

  Future<Map<String, dynamic>> getDoubts() async {
    Map<String, Object?> result;

    fetchDoubtsStatus = Status.Sending;
    final String email = UserProvider().getEmail();
    try {
      final Response response = await _client.post(
        Endpoints.UserSolved,
        data: {"username": email},
      );

      final Response response2 = await _client.post(
        Endpoints.UserPending,
        data: {"username": email},
      );

      final Response response3 = await _client.post(
        Endpoints.UserSubmitted,
        data: {"username": email},
      );

      if (response.statusCode == 200 &&
          response2.statusCode == 200 &&
          response3.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        final Map<String, dynamic> response2Data =
            Map<String, dynamic>.from(response2.data);

        final Map<String, dynamic> response3Data =
            Map<String, dynamic>.from(response3.data);

        final List<Doubt> doubtList = [];

        for (final data in responseData['QuestionsDetails']) {
          print(data);
          final Doubt doubt = Doubt.fromJson(data);
          doubtList.add(doubt);
        }

        for (final data in response2Data['QuestionsDetails']) {
          final Doubt doubt = Doubt.fromJson(data);
          doubtList.add(doubt);
        }

        for (final data in response3Data['QuestionsDetails']) {
          final Doubt doubt = Doubt.fromJson(data);
          doubtList.add(doubt);
        }
        _solvedDoubts = doubtList;
        fetchDoubtsStatus = Status.Success;
        notify();
        result = {
          'status': true,
          'message': "Fetched Successfully!",
        };
      } else {
        fetchDoubtsStatus = Status.Error;
        notify();
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      fetchDoubtsStatus = Status.Init;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> rateDoubt({
    required String id,
    required int rating,
    required String username,
  }) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> ratingData = {
      "id": id,
      "rating": rating,
      "username": username,
    };
    notify();
    try {
      final Response response = await _client.post(
        Endpoints.RateDoubt,
        data: ratingData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        if (responseData["acknowledged"]) {
          result = {
            'status': true,
            'message': "Your rating was submitted",
          };
        } else {
          result = {
            'status': false,
            'message': "Something went wrong",
          };
        }
      } else {
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      _doubtUploadStatus = Status.Error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }

    return result;
  }
}

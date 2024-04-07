import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import '../api_manager/dio client/dio_client.dart';
import '../constants/constants_export.dart';
import '../models/question_of_day_model.dart';

enum Status {
  Init,
  Fetching,
  Success,
  Error,
}

class QuestionOfTheDayProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _status = Status.Init;
  Status get status => _status;
  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  QuestionOfTheDayModel? _questionOfTheDay;

  QuestionOfTheDayModel? get questionOfTheDay => _questionOfTheDay;
  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchQuestion() async {
    Map<String, dynamic> result;
    try {
      final responseData =
          await _client.get(Endpoints.serverURL + Endpoints.QuestionOfTheDay);
      if (responseData['success'] == true) {
        _questionOfTheDay = QuestionOfTheDayModel.fromJson(responseData);
        notify();
        result = {
          'status': true,
          'message': responseData["message"],
        };
      } else {
        result = {
          'status': false,
          'message': responseData["message"],
        };
        notify();
      }
    } on DioError catch (e) {
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return result;
  }
}

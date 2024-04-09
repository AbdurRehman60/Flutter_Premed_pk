import 'package:flutter/cupertino.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import 'package:premedpk_mobile_app/providers/decks_provider.dart';

import '../constants/constants_export.dart';

enum FetchStatus { init, fetching, success, error }

class QuestionsProvider extends ChangeNotifier {
  FetchStatus _loadingStatus = FetchStatus.init;
  FetchStatus get loadingStatus => _loadingStatus;
  set loadingStatus(FetchStatus value) {
    _loadingStatus = value;
  }

  List _questionsIds = [];
  List get qids => _questionsIds;

  void notify(){
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchQuestions() async {
    Map<String, dynamic> result;
    final DioClient _client = DioClient();
    try {
      // print('fetching');
      final Response response = await _client.post(
        Endpoints.getDeckInfo + Endpoints.sindhPoints,
        data: {"userId": '65e060e0776e8c06b77b198d'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        // print(responseData);
        if (responseData["success"]) {
          final Map<String, dynamic> json = responseData["deck"];
          print(json);
          final deckQuestions = json['questions'];
          _questionsIds = deckQuestions;
          notifyListeners();
          print(_questionsIds);


          // _userStatModel = UserStatModel.fromJson(json);
          // notify();
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
        _loadingStatus = FetchStatus.error;
        // notify();
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      _loadingStatus = FetchStatus.error;
      // notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return result;
  }

  void fetchdeckQuestions() async {
    Map<String, dynamic> result;
    final DioClient _client = DioClient();
    try {
      final Response response = await _client.post(
        Endpoints.getDeckInfo + Endpoints.sindhPoints,
        data: {"userId": '65e060e0776e8c06b77b198d'},
      );
      print(response);
    } catch (e) {}
  }
}

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

  List _deckQuestions = [];
  List get qids => _deckQuestions;

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchQuestions() async {
    Map<String, dynamic> result;
    final DioClient _client = DioClient();
    try {
      // print('fetching');
      final response = await _client.get(
        '${Endpoints.getQuestions}NUMS Mock Paper 2',
      );

      // print(responseData);
      if (response["success"]) {
        final List rawQuestion = response["questions"];
        // print(rawQuestion);
        // print(rawQuestion.length);
        // final question = rawQuestion[1];
        // print(question);
        // final againQuestion = QuestionModel.fromJson(question);
        // print('choices are here ${againQuestion.questionText}');
        final List<QuestionModel> questions = rawQuestion.map((eQuestion) {
          return QuestionModel.fromJson(eQuestion);
        }).toList();
        _deckQuestions = questions;
        notifyListeners();
        // print(questions[2].questionText);
        // final deckQuestions = json['questions'];
        // _questionsIds = deckQuestions;
        // notifyListeners();
        // print(_questionsIds);

        // _userStatModel = UserStatModel.fromJson(json);
        // notify();
        result = {
          'status': true,
          'message': response["message"],
        };
      } else {
        result = {
          'status': false,
          'message': response["message"],
        };
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

  // void fetchdeckQuestions() async {
  //   Map<String, dynamic> result;
  //   final DioClient _client = DioClient();
  //   try {
  //     final Response response = await _client.post(
  //       Endpoints.getDeckInfo + Endpoints.sindhPoints,
  //       data: {"userId": '65e060e0776e8c06b77b198d'},
  //     );
  //     print(response);
  //   } catch (e) {}
  // }
}

import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';

import '../constants/constants_export.dart';

enum FetchStatus { init, fetching, success, error }

class QuestionsProvider extends ChangeNotifier {
  FetchStatus _loadingStatus = FetchStatus.init;
  FetchStatus get loadingStatus => _loadingStatus;

  int _questionBankLenght = 0;
  int questionIndex = 0;
  int get _questionIndex => questionIndex;

  String? _selectedOption;

  final Map<String, String> selectedOptions = {};

  void setSelectedOption(String optionLetter) {
    selectedOptions[questionIndex.toString()] = optionLetter;
    _selectedOption = optionLetter;
    notifyListeners();
  }

  String? get selectedOption {
    if (selectedOptions.containsKey(questionIndex.toString())) {
      return selectedOptions[questionIndex.toString()];
    }
    return null;
  }

  void getNextQuestion() {
    if (questionIndex <= _questionBankLenght - 1) {
      questionIndex++;
      _selectedOption = selectedOptions[questionIndex.toString()];
      notifyListeners();
    }
  }

  void getPreviousQuestion() {
    if (questionIndex > 0) {
      questionIndex--;
      _selectedOption = selectedOptions[questionIndex.toString()];
      notifyListeners();
    }
  }

  void resetSelectedOption() {
    _selectedOption = null;
    notifyListeners();
  }




  set loadingStatus(FetchStatus value) {
    _loadingStatus = value;
  }

  List<QuestionModel> _deckQuestions = [];
  List<QuestionModel> get questions => _deckQuestions;

  late QuestionModel _model;
  QuestionModel get qmode => _model;

  FetchStatus _fetchstatus = FetchStatus.init;
  FetchStatus get fetchstatus => _fetchstatus;

  resetIndex() {
    questionIndex = 0;
    notify();
  }

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchQuestions(String deckName) async {
    resetIndex();
    Map<String, dynamic> result;
    _fetchstatus = FetchStatus.fetching;
    final DioClient dio = DioClient();
    try {
      final responseData = await dio.get(
        '${Endpoints.getQuestions}$deckName',
      );

      if (responseData['success']) {
        final List rawQuestion = responseData["questions"];
        final List<QuestionModel> questions = [];
        for (var q in rawQuestion) {
          final QuestionModel model = QuestionModel.fromJson(q);
          // print(model.questionText);
          questions.add(model);
        }
        _deckQuestions = questions;
        _questionBankLenght = questions.length;
        // print(_deckQuestions[0].questionText);
        // print(questionModelList[0].questionText);
        // _deckQuestions = questionModelList;
        notify();
      } else {
        result = {
          'status': false,
          'message': responseData["message"],
        };
      }
      result = {
        'status': true,
        'message': responseData["message"],
      };
    } on DioError catch (e) {
      _fetchstatus = FetchStatus.error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return result;
  }
}

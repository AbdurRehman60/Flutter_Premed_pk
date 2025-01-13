import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';

import '../api_manager/dio client/dio_client.dart';
import '../constants/constants_export.dart';

enum Status {
  init,
  fetching,
  success,
}


class SaveQuestionProvider extends ChangeNotifier {
  SaveQuestionProvider();

  final DioClient dioClient = DioClient();
  Status status = Status.init;
  String message = '';
  List<Map<String, String>> savedQuestions = [];

  // Save a question
  Future<void> saveQuestion(String questionId, String subject, String userId) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await dioClient.post(
        Endpoints.handleSavedQuestion,
        data: {
          'userId': userId,
          'questionId': questionId,
          'subject': subject,
          'add' : true

        },
      );

      if (response.statusCode == 200) {
        print("question has been saved this is the userid  and questionid $questionId and subject $subject");
        status = Status.success;
        message = 'Question saved successfully';
        savedQuestions.add({'questionId': questionId, 'subject': subject});
      } else {
        status = Status.init;
        message = 'Failed to save question';
      }
    } catch (error) {
      message = 'Error: ${error.toString()}';
      status = Status.init;
    } finally {
      notifyListeners();
    }
  }

  // Remove a saved question
  Future<void> removeQuestion(String questionId, String subject, String userId) async {
    status = Status.fetching;
    notifyListeners();

    try {
      print('subjjj: $subject');
      final response = await dioClient.post(
        Endpoints.handleSavedQuestion,
        data: {
          'userId': userId,
          'questionId': questionId,
          'subject': subject,
          'remove': true,
        },
      );

      if (response.statusCode == 200) {
        status = Status.init;
        message = 'Question removed successfully';
        savedQuestions.removeWhere((savedQuestion) =>
        savedQuestion['questionId'] == questionId &&
            savedQuestion['subject'] == subject);
      } else {
        status = Status.init;
        message = 'Failed to remove question';
      }
    } catch (error) {
      message = 'Error: ${error.toString()}';
      status = Status.init;
    } finally {
      notifyListeners();
    }
  }

// bool isQuestionSaved(String questionId, String subject) {
//   print('toChecK id: $questionId');
//   print('subject toCheck: $subject');
//
//   for (var savedQuestion in savedQuestions) {
//     bool isIdMatch = savedQuestion['questionId'] == questionId;
//     bool isSubjectMatch = savedQuestion['subject'] == subject;
//
//     print('Checking savedQuestion: ${savedQuestion['questionId']}');
//     print('Subject of savedQuestion: ${savedQuestion['subject']}');
//     print('Is questionId match? $isIdMatch');
//     print('Is subject match? $isSubjectMatch');
//
//     if (isIdMatch && isSubjectMatch) {
//       print('Question is saved');
//       return true;
//     }
//   }
//
//   print('Question is not saved');
//   return false;
// }

}

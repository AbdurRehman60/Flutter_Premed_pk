import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';

import '../api_manager/dio client/dio_client.dart';
import '../constants/constants_export.dart';

enum Status {
  init,
  fetching,
  success,
}
//
// class SaveQuestionProvider extends ChangeNotifier {
//   SaveQuestionProvider();
//
//   final Dio dio = Dio();
//   Status status = Status.init;
//   String message = '';
//   List<Map<String, String>> savedQuestions = [];
//
//   // save
//   Future<void> saveQuestion(String questionId, String subject,
//       String userId) async {
//     print('questiondfrom test interface: $questionId');
//     print('subjectfrom test interface: $subject');
//     print('useridfrom test interface: $userId');
//     status = Status.fetching;
//     notifyListeners();
//
//     try {
//       final response = await dio.post(
//         Endpoints.handleSavedQuestion,
//         data: {
//           'userId': userId,
//           'questionId': questionId,
//           'subject': subject,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         print('if passed');
//         status = Status.success;
//         message = 'Question saved successfully';
//
//         savedQuestions.add({'questionId': questionId, 'subject': subject});
//       } else {
//         status = Status.init;
//         message = 'Failed to save question';
//       }
//     } catch (error) {
//       print('else calle');
//       status = Status.init;
//       message = 'Error: $error';
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   // to remove
//   Future<void> removeQuestion(String questionId, String subject,
//       String userId) async {
//     print('objectidfrompro :$questionId');
//     print('objectsubjectfropro:$subject');
//     status = Status.fetching;
//     notifyListeners();
//
//     try {
//       print('entered');
//       final response = await dio.post(
//         Endpoints.serverURL + Endpoints.handleSavedQuestion,
//         data: {
//           'userId': userId,
//           'questionId': questionId,
//           'subject': subject,
//           'remove': true,
//         },
//       );
//       if (response.statusCode == 200) {
//         print('remocinv');
//         status = Status.init;
//         message = 'Question removed successfully';
//
//         savedQuestions.removeWhere((savedQuestion) =>
//         savedQuestion['questionId'] == questionId &&
//             savedQuestion['subject'] == subject);
//       } else {
//         status = Status.init;
//         message = 'Failed to remove question';
//       }
//     } catch (error) {
//       status = Status.init;
//       message = 'Error: $error';
//     } finally {
//       notifyListeners();
//     }
//   }

// check if saved
// bool isQuestionSaved(String questionId, String subject) {
//   print('toSave questionId: $questionId');
//   print('subejct Tsaved: $subject');
//   print('savedQuestionLength :${savedQuestions.length}');
//   return savedQuestions.any((savedQuestion) =>
//   savedQuestion['questionId'] == questionId &&
//       savedQuestion['subject'] == subject);
// }
// }

// }


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

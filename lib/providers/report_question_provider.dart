import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/endpoints.dart';

enum ReportStatus {
  Initial,
  Fetching,
  Success,
  Error,
}

class ReportQuestionProvider extends ChangeNotifier {
  final Dio dio = Dio();
  ReportStatus status = ReportStatus.Initial;
  String message = '';
  List<String> selectedIssues = [];

  void toggleIssue(String issue) {
    if (selectedIssues.contains(issue)) {
      selectedIssues.remove(issue);
    } else {
      selectedIssues.add(issue);
    }
    notifyListeners();
  }

  Future<void> reportQuestion({
    required String userId,
    required String questionId,
    required String problemText,
  }) async {
    status = ReportStatus.Fetching;
    notifyListeners();

    try {
      final response = await dio.post(
        Endpoints.addReport,
        data: {
          'userId': userId,
          'questionId': questionId,
          'problemText': problemText,
          'issues': selectedIssues,
        },
      );

      if (response.statusCode == 200) {
        status = ReportStatus.Success;
        message = 'Question reported successfully';
      } else {
        status = ReportStatus.Error;
        message = 'Failed to report question';
      }
    } catch (error) {
      status = ReportStatus.Error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }
}

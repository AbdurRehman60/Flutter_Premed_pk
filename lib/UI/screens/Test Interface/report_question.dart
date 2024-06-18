import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_textbox.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/report_question_provider.dart';
import '../../screens/Onboarding/widgets/check_box.dart';

class ReportQuestion extends StatelessWidget {
  const ReportQuestion({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportQuestionProvider>(context);
    final TextEditingController issueController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 28, bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'File ',
                            style: TextStyle(
                              color: PreMedColorTheme().black,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'Report',
                            style: TextStyle(
                              color: PreMedColorTheme().primaryColorRed,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(14, 0, 0, 0),
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarDividerColor: Colors.white,
              )),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                Text(
                    'If you find any error in the question, kindly file a report and we will rectify it at the earliest.',
                    style: PreMedTextTheme().body.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBoxes.verticalGargangua,
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          "Describe the issue",
                          style: PreMedTextTheme().subtext1.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBoxes.verticalTiny,
                    CustomTextBox(
                      height: 150,
                      controller: issueController,
                      borderRadius: 8,
                      hintText:
                      "In order for your report to be effective, kindly give us a detailed account of the issue. What was wrong? What error did you find? And kindly mention steps to reproduce the issue, if any. ",
                    ),
                    SizedBoxes.verticalGargangua,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'Select the issue type:',
                          style: PreMedTextTheme().body1.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBoxes.verticalLarge,
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        children: [
                          //checkboxes
                          CustomCheckBox(
                            initialValue: reportProvider.selectedIssues
                                .contains('Wrong Answer'),
                            onChanged: (value) {
                              if (value) {
                                reportProvider.selectedIssues
                                    .add('Wrong Answer');
                              } else {
                                reportProvider.selectedIssues
                                    .remove('Wrong Answer');
                              }
                            },
                            label: 'Wrong Answer',
                          ),
                          SizedBoxes.verticalLarge,
                          CustomCheckBox(
                            initialValue: reportProvider.selectedIssues
                                .contains('Incorrect Explanation'),
                            onChanged: (value) {
                              if (value) {
                                reportProvider.selectedIssues
                                    .add('Incorrect Explanation');
                              } else {
                                reportProvider.selectedIssues
                                    .remove('Incorrect Explanation');
                              }
                            },
                            label: 'Incorrect Explanation',
                          ),

                          SizedBoxes.verticalLarge,
                          CustomCheckBox(
                            initialValue: reportProvider.selectedIssues
                                .contains('Incorrect Question'),
                            onChanged: (value) {
                              if (value) {
                                reportProvider.selectedIssues
                                    .add('Incorrect Question');
                              } else {
                                reportProvider.selectedIssues
                                    .remove('Incorrect Question');
                              }
                            },
                            label: 'Incorrect Question',
                          ),

                          SizedBoxes.verticalLarge,
                          CustomCheckBox(
                            initialValue: reportProvider.selectedIssues
                                .contains('Incorrect Tags'),
                            onChanged: (value) {
                              if (value) {
                                reportProvider.selectedIssues
                                    .add('Incorrect Tags');
                              } else {
                                reportProvider.selectedIssues
                                    .remove('Incorrect Tags');
                              }
                            },
                            label: 'Incorrect Tags',
                          ),

                          SizedBoxes.verticalLarge,
                          CustomCheckBox(
                            initialValue: reportProvider.selectedIssues
                                .contains('Incorrect Options'),
                            onChanged: (value) {
                              if (value) {
                                reportProvider.selectedIssues
                                    .add('Incorrect Options');
                              } else {
                                reportProvider.selectedIssues
                                    .remove('Incorrect Options');
                              }
                            },
                            label: 'Incorrect Options',
                          ),
                          SizedBoxes.verticalLarge,
                          CustomCheckBox(
                            initialValue: reportProvider.selectedIssues
                                .contains('Incorrect Answer'),
                            onChanged: (value) {
                              if (value) {
                                reportProvider.selectedIssues
                                    .add('Incorrect Answer');
                              } else {
                                reportProvider.selectedIssues
                                    .remove('Incorrect Answer');
                              }
                            },
                            label: 'Incorrect Answer',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ])),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              buttonText: 'Submit',
              onPressed: () async {
                final userId = UserProvider().getEmail();
                final problemText = issueController.text;
                reportProvider.toggleIssue('someIssue');

                await reportProvider.reportQuestion(
                  userId: userId,
                  questionId: questionId,
                  problemText: problemText,
                );
                // print('UserID: $userId');
                // print('QuestionID: $questionId');
                // print('ProblemText: $problemText');
                // print('SelectedIssues: ${reportProvider.selectedIssues}');
                // print('Status: ${reportProvider.status}');
                // print('Message: ${reportProvider.message}');

                if (reportProvider.status == ReportStatus.Success) {
                  showSnackbar(
                    context,
                    "Question reported successfully",
                    SnackbarType.SUCCESS,
                  );
                } else if (reportProvider.status == ReportStatus.Error) {
                  showSnackbar(
                    context,
                    "Failed to report question: ${reportProvider.message}",
                    SnackbarType.INFO,
                  );
                }
                Navigator.of(context).pop();
              },
            ),
            SizedBoxes.verticalMicro,
            CustomButton(
              buttonText: 'Cancel',
              color: PreMedColorTheme().white,
              textColor: PreMedColorTheme().primaryColorRed,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void submitReport(
    String userId,
    String questionId,
    String problemText,
    List<String> issues,
    ) {
  print('Submitting report...');
  print('User ID (Email): $userId');
  print('Question ID: $questionId');
  print('Problem Text: $problemText');
  print('Issues: $issues');
}
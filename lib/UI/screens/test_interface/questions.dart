import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/handle_saved_ques_provider.dart';
import 'package:premedpk_mobile_app/providers/test_interface_provider.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  final questionProvider = QuestionProvider();

  @override
  void initState() {
    super.initState();
    questionProvider.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('QUESTIONS',
                style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: PreMedColorTheme().black,
                    ))
          ],
        ),
      ),
      body: Consumer2<QuestionProvider, SaveQuestionProvider>(
        builder: (context, questionProvider, saveQuestionProvider, child) {
          if (questionProvider.questions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: PageView(
                        controller:
                            PageController(initialPage: currentQuestionIndex),
                        onPageChanged: (index) {
                          setState(() {
                            currentQuestionIndex = index;
                          });
                        },
                        children: questionProvider.questions.map((question) {
                          return ListTile(
                            title: Text(
                              removeHtmlTags(question.questionText),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: question.tags.isEmpty
                                ? const Text(
                                    'No tags associated with this question.')
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Deck Name: ${question.deckName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Subject: ${question.subject}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Topic: ${question.topic}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "ques id: ${question.questionId}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(12),
                          child: CustomButton(
                            color: Colors.white30,
                            isOutlined: true,
                            onPressed: () {},
                            buttonText: 'Report Question',
                            textColor: PreMedColorTheme().neutral500,
                          ),
                        ),
                      ),
                      SizedBoxes.horizontalMedium,
                      Expanded(
                        child: Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(12),
                          child: Consumer<SaveQuestionProvider>(
                            builder: (context, saveQuestionProvider, child) {
                              final String questionId = questionProvider
                                  .questions[currentQuestionIndex].questionId;
                              final String subject = questionProvider
                                  .questions[currentQuestionIndex].subject;
                              final bool isSaved = saveQuestionProvider
                                  .isQuestionSaved(questionId, subject);
                              final buttonText = isSaved
                                  ? 'Remove Question'
                                  : 'Save Question';
                              return CustomButton(
                                color: Colors.red,
                                isOutlined: true,
                                onPressed: () {
                                  print('Button pressed');
                                  print(
                                      'Current question index: $currentQuestionIndex');
                                  print(
                                      'Question ID: $questionId, Subject: $subject, Status: ${saveQuestionProvider.status}');

                                  if (isSaved) {
                                    print('Removing question...');
                                    saveQuestionProvider.removeQuestion(
                                        questionId, subject);
                                  } else {
                                    print('Saving question...');
                                    saveQuestionProvider.saveQuestion(
                                        questionId, subject);
                                  }
                                },
                                buttonText: buttonText,
                                textColor: PreMedColorTheme().neutral500,
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

String removeHtmlTags(String htmlText) {
  final RegExp exp = RegExp(r"<[^>]*>", multiLine: true);
  return htmlText.replaceAll(exp, '');
}

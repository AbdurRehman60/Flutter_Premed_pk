import 'package:html/parser.dart' as htmlparser;
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../providers/question_provider.dart';

class TestInterface extends StatefulWidget {
  const TestInterface({super.key, required this.deckName});
  final String deckName;

  @override
  State<TestInterface> createState() => _TestInterfaceState();
}

class _TestInterfaceState extends State<TestInterface> {
  int currentQuestionIndex = 0;
  int currentPage = 1;
  String? selectedOption;
  bool optionSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
      questionProvider.deckName = widget.deckName;
      questionProvider.fetchQuestions(questionProvider.deckName, currentPage);
    });
  }

  String? parse(String toParse) {
    return htmlparser.parse(toParse).body?.text;
  }

  void nextQuestion() {
    setState(() {
      final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
      if (currentQuestionIndex < questionProvider.questions!.length - 1) {
        currentQuestionIndex++;
        selectedOption = null;
        optionSelected = false;

        if (currentQuestionIndex % 10 == 7 && currentPage < 20) {
          currentPage++;
          questionProvider.fetchQuestions(questionProvider.deckName, currentPage);
        }
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        selectedOption = null;
        optionSelected = false;
      }
    });
  }

  void selectOption(String optionLetter) {
    if (!optionSelected) {
      setState(() {
        selectedOption = optionLetter;
        optionSelected = true;
      });
    }
  }

  bool isBase64(String str) {
    try {
      base64Decode(str.split(',').last);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppBar(
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
                  icon: Icon(Icons.arrow_back,
                      color: PreMedColorTheme().primaryColorRed),
                  onPressed: previousQuestion,
                ),
              ),
            ),
            title: Center(
              child: Consumer<QuestionProvider>(
                builder: (context, questionProvider, child) {
                  final questionNumber = currentQuestionIndex + 1;
                //  final totalQuestions = questionProvider.questions?.length ?? 0;
                  return Text(
                    'QUESTION $questionNumber',
                    style: PreMedTextTheme().heading6.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 40,
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
                    icon: Icon(Icons.arrow_forward,
                        color: PreMedColorTheme().primaryColorRed),
                    onPressed: nextQuestion,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, questionProvider, child) {
          final questions = questionProvider.questions;
          if (questions == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (questions.isEmpty) {
            return const Center(child: Text('No questions available'));
          }

          if (currentQuestionIndex >= questions.length) {
            currentQuestionIndex = questions.length - 1;
          }
          if (currentQuestionIndex < 0) {
            currentQuestionIndex = 0;
          }

          final question = questions[currentQuestionIndex];
          final parsedQuestionText = parse(question.questionText);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parsedQuestionText ?? '',
                    style: PreMedTextTheme().body.copyWith(
                      color: PreMedColorTheme().black,
                    ),
                  ),
                  if (question.questionImage != null && question.questionImage!.isNotEmpty)
                    if (isBase64(question.questionImage!))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Image.memory(
                                base64Decode(
                                  question.questionImage!.split(',').last,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(height:2),
                        // child: Material(
                        //   elevation: 4,
                        //   child: Center(
                        //     child: Padding(
                        //       padding: EdgeInsets.only(top: 16.0),
                        //       child: Text('Invalid image format'),
                        //     ),
                        //   ),
                        // ),
                      ),
                  const SizedBox(height: 16),
                  ...question.options.map((option) {
                    final parsedOptionText = parse(option.optionText);
                    final isSelected = option.optionLetter == selectedOption;
                    final borderColor = isSelected
                        ? (option.isCorrect ? Colors.green : Colors.red)
                        : PreMedColorTheme().neutral400;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => selectOption(option.optionLetter),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${option.optionLetter}. ',
                                  style: PreMedTextTheme().body.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    parsedOptionText ?? '',
                                    style: PreMedTextTheme().body.copyWith(
                                      color: PreMedColorTheme().black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

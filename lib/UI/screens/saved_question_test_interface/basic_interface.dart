import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants_export.dart';
import '../../../models/saved_question_model.dart';
import '../../../providers/flashcard_provider.dart';
import '../../../providers/save_question_provider.dart';
import '../../../providers/savedquestion_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/vaultProviders/premed_provider.dart';

class TestInterfaceScreen extends StatefulWidget {
  final List<SavedQuestionModel> questions;

  const TestInterfaceScreen({Key? key, required this.questions})
      : super(key: key);

  @override
  State<TestInterfaceScreen> createState() => _TestInterfaceScreenState();
}

class _TestInterfaceScreenState extends State<TestInterfaceScreen> {
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool optionSelected = false;
  Map<String, bool> showExplanation = {};
  bool isQuestionSaved = false;

  List<String?> selectedOptions = [];
  List<bool?> isCorrectlyAnswered = [];

  List<String> _eliminatedOptions = [];
  bool isEliminated = false;

  @override
  void initState() {
    super.initState();
    selectedOptions = List<String?>.filled(widget.questions.length, null);
    isCorrectlyAnswered = List<bool?>.filled(widget.questions.length, null);
  }

  void _eliminateOptions(List<String> options) {
    _eliminatedOptions = [options.removeAt(0), options.removeAt(0)];
    isEliminated = true;
    setState(() {});
  }

  void _undoElimination(List<String> options) {
    options.addAll(_eliminatedOptions);
    _eliminatedOptions = [];
    isEliminated = false;
    setState(() {});
  }

  void toggleSaveStatus() {
    final saveQuestionProvider = Provider.of<SaveQuestionProvider>(context, listen: false);
    final question = widget.questions[currentQuestionIndex];
    final userId = Provider.of<UserProvider>(context, listen: false).user?.userId ?? '';

    if (isQuestionSaved) {
      saveQuestionProvider.removeQuestion(question.id, question.subject, userId);
    } else {
      saveQuestionProvider.saveQuestion(question.id, question.subject, userId);
    }

    setState(() {
      isQuestionSaved = !isQuestionSaved;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = selectedOptions[currentQuestionIndex];
        optionSelected = selectedOption != null;
        showExplanation.clear();
        _eliminatedOptions.clear();
        isEliminated = false; // Reset elimination when moving to the next question
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        selectedOption = selectedOptions[currentQuestionIndex];
        optionSelected = selectedOption != null;
        showExplanation.clear();
        _eliminatedOptions.clear();
        isEliminated = false; // Reset elimination when moving to the previous question
      }
    });
  }

  void selectOption(String optionLetter) {
    final correctOption = widget.questions[currentQuestionIndex]
        .options
        .firstWhere((option) => option['isCorrect'] == true)['optionLetter'];

    setState(() {
      selectedOption = optionLetter;
      optionSelected = true;
      selectedOptions[currentQuestionIndex] = optionLetter;
      isCorrectlyAnswered[currentQuestionIndex] = optionLetter == correctOption;
    });
  }

  void toggleExplanation(String optionLetter) {
    setState(() {
      showExplanation[optionLetter] = !(showExplanation[optionLetter] ?? false);
    });
  }
  void showSnackBarr() {
    final flashcardpro =
    Provider.of<FlashcardProvider>(context, listen: false);
    final message = flashcardpro.additionStatus == 'Added'
        ? 'Added To Saved Facts'
        : 'Removed from Saved Facts';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            message,
            style: PreMedTextTheme().body.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Provider.of<PreMedProvider>(context).isPreMed
                        ? PreMedColorTheme().red
                        : PreMedColorTheme().blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    'OK',
                    style: PreMedTextTheme()
                        .body
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final question = widget.questions[currentQuestionIndex];
    final correctOption = question.options.firstWhere((option) => option['isCorrect'] == true)['optionLetter'];

    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppBar(
            backgroundColor: PreMedColorTheme().background,
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
                      color: Provider.of<PreMedProvider>(context).isPreMed
                          ? PreMedColorTheme().primaryColorRed
                          : PreMedColorTheme().blue),
                  onPressed: previousQuestion,
                ),
              ),
            ),
            title: Center(
              child: Text(
                'QUESTION ${currentQuestionIndex + 1}',
                style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black,
                  fontWeight: FontWeight.bold,
                ),
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
                        color: Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().primaryColorRed
                            : PreMedColorTheme().blue),
                    onPressed: nextQuestion,
                  ),
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.question,
                style: PreMedTextTheme().body.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: PreMedColorTheme().black,
                ),
              ),
              const SizedBox(height: 16),
              Row(children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    backgroundColor: isEliminated ? Colors.grey : const Color.fromRGBO(12, 90, 188, 1),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: isEliminated
                      ? () => _undoElimination(question.options.map((option) => option['optionLetter'] as String).toList())
                      : () => _eliminateOptions(question.options.map((option) => option['optionLetter'] as String).toList()),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        isEliminated
                            ? 'assets/icons/undo_elimination.svg'
                            : 'assets/icons/elimination.svg',
                      ),
                      const SizedBox(width: 5),
                      Text(isEliminated ? 'Undo Elimination' : 'Eliminate Options'),
                    ],
                  ),
                ),
                Consumer2<SaveQuestionProvider, SavedQuestionsProvider>(
                  builder: (context, saveQuestionProvider, savedQuestionsPro, child) {
                    final questionId = widget.questions[currentQuestionIndex].id;
                    final subject = widget.questions[currentQuestionIndex].subject;
                    final isSaved = savedQuestionsPro.isQuestionSaved(questionId, subject);
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.orange,
                      ),
                      onPressed: () async {
                        if (isSaved) {
                          await saveQuestionProvider.removeQuestion(questionId, subject, userProvider.user?.userId ?? '');
                          savedQuestionsPro.getSavedQuestions(userId: userProvider.user?.userId ?? '');
                        } else {
                          await saveQuestionProvider.saveQuestion(questionId, subject, userProvider.user?.userId ?? '');
                          savedQuestionsPro.getSavedQuestions(userId: userProvider.user?.userId ?? '');
                        }
                      },
                      child: SizedBox(
                        width: 90,
                        child: Row(
                          children: [
                            Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                            const SizedBox(width: 5),
                            Text(isSaved ? 'Remove' : 'Save'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],),
              const SizedBox(height: 16),
              ...question.options.map((option) {
                final String optionLetter = option['optionLetter'];

                // Hide eliminated options
                if (_eliminatedOptions.contains(optionLetter)) {
                  return const SizedBox.shrink();
                }

                final isCorrect = option['isCorrect'] as bool;
                final explanationText = option['choiceExplanationText'];
                bool shouldBeGreen = optionLetter == correctOption;
                bool shouldBeRed = optionLetter == selectedOption && !isCorrect;
                final borderColor = optionSelected
                    ? (shouldBeGreen
                    ? Colors.green
                    : (shouldBeRed
                    ? Colors.red
                    : PreMedColorTheme().neutral400))
                    : PreMedColorTheme().neutral400;
                final color = optionSelected
                    ? (shouldBeGreen
                    ? Colors.greenAccent
                    : (shouldBeRed
                    ? PreMedColorTheme().primaryColorRed200
                    : PreMedColorTheme().background))
                    : PreMedColorTheme().background;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: optionSelected ? null : () => selectOption(optionLetter),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(8),
                        color: color,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$optionLetter. ',
                                  style: PreMedTextTheme().body.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    color: PreMedColorTheme()
                                        .primaryColorRed,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    option['optionText'],
                                    style: PreMedTextTheme().body.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: PreMedColorTheme().black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (optionSelected && explanationText.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () => toggleExplanation(optionLetter),
                                child: SizedBox(
                                  width: 110,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Explanation"),
                                      Icon(showExplanation[optionLetter] ??
                                          false
                                          ? Icons.arrow_drop_up_rounded
                                          : Icons.arrow_drop_down_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if ((showExplanation[optionLetter] ?? false) &&
                              explanationText.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.8,
                                      color: PreMedColorTheme().neutral400),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    explanationText,
                                    style: PreMedTextTheme().body.copyWith(
                                      color: PreMedColorTheme().black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              if (optionSelected)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.8, color: PreMedColorTheme().neutral400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question.explanationText,
                        style: PreMedTextTheme().body.copyWith(
                          color: PreMedColorTheme().black,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.questions.length,
                itemBuilder: (context, index) {
                  final bool isAttempted = selectedOptions[index] != null;
                  final bool isCurrent = index == currentQuestionIndex;
                  final bool isCorrect = isCorrectlyAnswered[index] == true;
                  final bool isIncorrect = isCorrectlyAnswered[index] == false;

                  // Circle avatar color logic based on current question, correctness, and attempt status
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentQuestionIndex = index;
                        selectedOption = selectedOptions[currentQuestionIndex];
                        optionSelected = selectedOption != null;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Center(
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            border: Border.all(
                              color: isAttempted
                                  ? Colors.transparent
                                  : (isCurrent ? Colors.blue : Colors.white),
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: isAttempted ?
                            Colors.blue : PreMedColorTheme().white,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color:
                                isAttempted ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: MediaQuery.of(context).size.width > 600 ? 80 : 60,
                  width: MediaQuery.of(context).size.width > 600 ? 480 : 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: PreMedColorTheme().primaryColorRed),
                            color: PreMedColorTheme().white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                final currentQuestion =
                                widget.questions[currentQuestionIndex];
                                await Provider.of<FlashcardProvider>(context,
                                    listen: false)
                                    .removeFlashcard(
                                  userId: userProvider.user!.userId,
                                  subject: currentQuestion.subject,
                                  questionId: currentQuestion.id,
                                );
                                showSnackBarr();
                              },
                              child: Image.asset(PremedAssets.Flashcards),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${currentQuestionIndex + 1} of ${widget.questions.length}",
                            style: PreMedTextTheme().body.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: PreMedColorTheme().neutral800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "ATTEMPTED",
                            style: PreMedTextTheme().body.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: PreMedColorTheme().neutral400,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: PreMedColorTheme().primaryColorRed),
                            color: PreMedColorTheme().white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                // Implement your logic here
                              },
                              child: Image.asset(PremedAssets.Flask),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:premedpk_mobile_app/UI/screens/The%20vault/saved_question/widget/topic_button.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/models/saved_question_model.dart';
import 'package:premedpk_mobile_app/providers/savedquestion_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../UI/screens/The vault/saved_question/activity_cell.dart';
import '../../../../constants/constants_export.dart';

class SavedQuestionScreenEng extends StatefulWidget {
  const SavedQuestionScreenEng({super.key});

  @override
  State<SavedQuestionScreenEng> createState() => _SavedQuestionScreenEngState();
}

class _SavedQuestionScreenEngState extends State<SavedQuestionScreenEng> {
  String _activeTopic = 'Mathematics';
  List<SavedQuestionModel> _filteredQuestions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userPro = Provider.of<UserProvider>(context,listen: false);
      final provider =
      Provider.of<SavedQuestionsProvider>(context, listen: false);
      provider.getSavedQuestions(userId: userPro.user!.userId);
    });
  }

  void _handleTopicTap(String topicName) {
    setState(() {
      _activeTopic = topicName;
      _filterQuestions();
    });
  }

  void _filterQuestions() {
    final provider =
    Provider.of<SavedQuestionsProvider>(context, listen: false);
    if (_activeTopic == 'All Questions') {
      _filteredQuestions = provider.savedQuestions;
    } else {
      _filteredQuestions = provider.savedQuestions
          .where((question) => question.subject == _activeTopic)
          .toList();

      // Print the matching questions
      _filteredQuestions.forEach((question) {
        print('Matching Question: ${question.subject}');// Adjust according to your question model's fields
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Card(
                  elevation: 3,
                  color: Provider.of<PreMedProvider>(context).isPreMed ?PreMedColorTheme().primaryColorRed : PreMedColorTheme().blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  child: InkWell(
                    onTap: () => _handleTopicTap('All Questions'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                      child: Text('All Questions',
                          style: PreMedTextTheme().heading1.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            leading: const PopButton(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saved Question',
                style: PreMedTextTheme()
                    .body
                    .copyWith(fontSize: 34, fontWeight: FontWeight.w800),
              ),
              SizedBoxes.vertical3Px,
              Text(
                "Easily access questions you've marked for later study.",
                style: PreMedTextTheme()
                    .body
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              SizedBoxes.vertical15Px,
              Wrap(
                spacing: 12.0, // Space between buttons
                runSpacing: 2.0, // Space between lines
                children: [
                  SavedQuestionTopicButton(
                    topicName: 'Mathematics',
                    isActive: _activeTopic == 'Mathematics',
                    onTap: () => _handleTopicTap('Mathematics'),
                  ),
                  SavedQuestionTopicButton(
                    topicName: 'Physics',
                    isActive: _activeTopic == 'Physics',
                    onTap: () => _handleTopicTap('Physics'),
                  ),
                  SavedQuestionTopicButton(
                    topicName: 'Chemistry',
                    isActive: _activeTopic == 'Chemistry',
                    onTap: () => _handleTopicTap('Chemistry'),
                  ),
                  SavedQuestionTopicButton(
                    topicName: 'English',
                    isActive: _activeTopic == 'English',
                    onTap: () => _handleTopicTap('English'),
                  ),
                  SavedQuestionTopicButton(
                    topicName: 'Computer Science',
                    isActive: _activeTopic == 'Practice Question',
                    onTap: () => _handleTopicTap('Practice Question'),
                  ),
                  SavedQuestionTopicButton(
                    topicName: 'Math Reasoning',
                    isActive: _activeTopic == 'Math Reasoning',
                    onTap: () => _handleTopicTap('Math Reasoning'),
                  ),
                ],
              ),
              SizedBoxes.verticalBig,
              Consumer<SavedQuestionsProvider>(
                builder: (context, savedQuestionsProvider, _) {
                  if (savedQuestionsProvider.fetchStatus == FetchStatus.init) {
                    final userProvider = Provider.of<UserProvider>(context,listen: false);
                    savedQuestionsProvider.getSavedQuestions(userId: userProvider.user!.userId);
                  }
                  if (savedQuestionsProvider.fetchStatus ==
                      FetchStatus.success) {
                    _filterQuestions();
                  }
                  switch (savedQuestionsProvider.fetchStatus) {
                    case FetchStatus.init:
                    case FetchStatus.fetching:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case FetchStatus.success:
                      if(_filteredQuestions.isEmpty){
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  PremedAssets.emptySQ,
                                  height: 65,
                                  width: 65,
                                  color: PreMedColorTheme().blue,
                                ),
                                SizedBoxes.vertical15Px,
                                const Center(
                                  child: Text(
                                    'No Saved Questions',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBoxes.vertical5Px,
                                const Center(
                                  child: Text(
                                    'No Saved Questions for the selected topic.',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }else {
                        return SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: _filteredQuestions.length,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3),
                                  child: ActivityCell(
                                    savedQuestionModel: _filteredQuestions[index],
                                  ),
                                ),
                          ),
                        );
                      }

                    case FetchStatus.error:
                      return const Center(
                        child: Text('Error Fetching Data'),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
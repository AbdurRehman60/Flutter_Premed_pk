import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/saved_question/widget/topic_button.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/models/saved_question_model.dart';
import 'package:premedpk_mobile_app/providers/savedquestion_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/user_provider.dart';
import '../../../../providers/vaultProviders/premed_provider.dart';
import '../../saved_question_test_interface/test_interface_basic.dart';
import 'activity_cell.dart';

class SavedQuestionScreen extends StatefulWidget {
  const SavedQuestionScreen({super.key});

  @override
  State<SavedQuestionScreen> createState() => _SavedQuestionScreenState();
}

class _SavedQuestionScreenState extends State<SavedQuestionScreen> {
  String _activeTopic = 'Biology'; // Default topic
  List<SavedQuestionModel> _filteredQuestions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userPro = Provider.of<UserProvider>(context, listen: false);
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

  // When "All Questions" is tapped, navigate to TestInterfaceScreen with the filtered questions
  void _navigateToTestInterface() {
    if (_filteredQuestions.isNotEmpty)
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              TestInterfaceScreen(questions: _filteredQuestions),
        ),
      );
  }

  // Filter questions based on the selected topic or "All Questions"
  void _filterQuestions() {
    final provider =
        Provider.of<SavedQuestionsProvider>(context, listen: false);
    if (_activeTopic == 'All Questions') {
      _filteredQuestions = provider.savedQuestions;
    } else {
      // Filter questions based on the active topic (like Biology, Physics, etc.)
      _filteredQuestions = provider.savedQuestions
          .where((question) => question.subject == _activeTopic)
          .toList();
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
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Card(
                  elevation: 3,
                  color: PreMedColorTheme().primaryColorRed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  child: InkWell(
                    onTap: _navigateToTestInterface, // Navigate to Test Screen
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                      child: Text(
                        'Attempt Questions',
                        style: PreMedTextTheme().heading1.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
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
                    topicName: 'All',
                    isActive: _activeTopic == 'All Questions',
                    onTap: () => _handleTopicTap('All Questions'),
                  ),
                  SavedQuestionTopicButton(
                    topicName: 'Biology',
                    isActive: _activeTopic == 'Biology',
                    onTap: () => _handleTopicTap('Biology'),
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
                    topicName: 'Science Reasoning',
                    isActive: _activeTopic == 'Science Reasoning',
                    onTap: () => _handleTopicTap('Science Reasoning'),
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
                  switch (savedQuestionsProvider.fetchStatus) {
                    case FetchStatus.init:
                    case FetchStatus.fetching:
                      return _buildLoadingIndicator(context);
                    case FetchStatus.success:
                      _filterQuestions();
                      return _buildQuestionsList();
                    case FetchStatus.error:
                      return const Center(child: Text('Error Fetching Data'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Provider.of<PreMedProvider>(context, listen: false).isPreMed
            ? PreMedColorTheme().red
            : PreMedColorTheme().blue,
      ),
    );
  }

  Widget _buildQuestionsList() {
    if (_filteredQuestions.isEmpty) {
      return _buildNoQuestionsView();
    } else {
      return ListView.builder(
        shrinkWrap: true, // Adjusts to the content height
        physics: const NeverScrollableScrollPhysics(), // Avoid nested scrolling
        itemCount: _filteredQuestions.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: ActivityCell(
            savedQuestionModel: _filteredQuestions[index],
          ),
        ),
      );
    }
  }

  Widget _buildNoQuestionsView() {
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
            ),
            SizedBoxes.vertical15Px,
            const Text(
              'No Saved Questions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBoxes.vertical5Px,
            const Text(
              'No Saved Questions for the selected topic.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

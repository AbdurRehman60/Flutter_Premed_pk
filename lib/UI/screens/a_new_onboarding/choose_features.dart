import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/thankyou_screen.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import '../../../models/onboarding_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/onboarding_provider.dart';
import '../../../providers/user_provider.dart';
import '../marketplace/checkout/thankyou.dart';

class ChooseFeatures extends StatefulWidget {
  const ChooseFeatures(
      {super.key,
      this.password,
      required this.selectedExam,
      required this.category,
      required this.city,
      required this.phoneNumber,
      required this.institution,
      required this.lastOnboarding,
      required this.educationSystem});

  final String? password;
  final String lastOnboarding;
  final String educationSystem;
  final String city;
  final String phoneNumber;
  final String institution;
  final String selectedExam;
  final String category;

  @override
  State<ChooseFeatures> createState() => _ChooseFeaturesState();
}

class _ChooseFeaturesState extends State<ChooseFeatures> {
  final Set<int> _selectedIndexes = {};
  bool hasErrors = false;
  String error = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final boardProvider = Provider.of<BoardProvider>(context, listen: false);
      boardProvider.fetchBoards(widget.category);
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndexes.contains(index)) {
        _selectedIndexes.remove(index);
      } else {
        _selectedIndexes.add(index);
      }
    });
  }

  List<String> getSelectedFeatures(Board selectedBoard) {
    return _selectedIndexes
        .map((index) => selectedBoard.tags[index].featureName)
        .toList();
  }

  Future<void> saveUserTrack() async {
    if (widget.lastOnboarding
        .contains('auth/onboarding/flow/entrance-exam/pre-engineering')) {
      final preMedPro = Provider.of<PreMedProvider>(context, listen: false);
      preMedPro.setPreMed(false);
    }
  }

  Future<void> submitOnboardingData() async {
    final AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final String? username = userProvider.user?.userName;
    final boardProvider = Provider.of<BoardProvider>(context, listen: false);
    final boards = boardProvider.boards;
    final selectedBoard = boards.firstWhere(
      (board) => board.boardName == widget.selectedExam,
      orElse: () => Board(id: '', boardName: '', position: 0, tags: []),
    );

    final List<String> features = getSelectedFeatures(selectedBoard);

    try {
      final result = await auth.requiredOnboarding(
        username: username!,
        lastOnboardingPage: widget.lastOnboarding +
            "/additional-info/features/recommended-bundles",
        selectedExams: [widget.selectedExam],
        selectedFeatures: features,
        city: widget.city,
        educationSystem: widget.educationSystem,
        year: '',
        parentContactNumber: '',
        approach: '',
        phoneNumber: widget.phoneNumber,
        institution: widget.institution,
      );

      if (result['status']) {
        print(" after all of the apis${widget.lastOnboarding}");
        await saveUserTrack();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const ThankyouScreen(),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          error = 'Failed to submit data. Please try again.';
          hasErrors = true;
        });
        showErrorDialog(error);
      }
    } catch (e) {
      setState(() {
        error = 'An error occurred. Please try again.';
        hasErrors = true;
      });
      showErrorDialog(error);
    }
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);

    if (boardProvider.isLoading) {
      return Scaffold(
        backgroundColor: PreMedColorTheme().neutral60,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (boardProvider.errorMessage != null) {
      return Scaffold(
        backgroundColor: PreMedColorTheme().neutral60,
        body: Center(child: Text(boardProvider.errorMessage!)),
      );
    }

    final boards = boardProvider.boards;
    final selectedBoard = boards.firstWhere(
      (board) => board.boardName == widget.selectedExam,
      orElse: () => Board(id: '', boardName: '', position: 0, tags: []),
    );

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxes.verticalExtraGargangua,
            RichText(
              text: TextSpan(
                style: PreMedTextTheme().subtext.copyWith(
                      color: PreMedColorTheme().black,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                children: [
                  const TextSpan(text: 'What '),
                  TextSpan(
                    text: 'features ',
                    style: PreMedTextTheme().heading3.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: PreMedColorTheme().highschoolblue,
                        ),
                  ),
                  TextSpan(
                    text: 'do you want?',
                    style: PreMedTextTheme().subtext1.copyWith(
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalGargangua,
            Text(
              'You can select more than one',
              style: PreMedTextTheme().body.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBoxes.verticalLarge,
            Expanded(
              child: ListView.builder(
                itemCount: selectedBoard.tags.length,
                itemBuilder: (context, index) {
                  final feature = selectedBoard.tags[index];
                  final isSelected = _selectedIndexes.contains(index);

                  return GestureDetector(
                    onTap: () => _toggleSelection(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? PreMedColorTheme().primaryColorRed
                              : const Color(0x80FFFFFF),
                          width: 5,
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.network(
                            feature.iconLink,
                            width: 24,
                            height: 24,
                          ),
                          SizedBoxes.horizontal10Px,
                          Text(
                            feature.featureName,
                            style: PreMedTextTheme().heading3.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: PreMedColorTheme().black,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: PreMedColorTheme().primaryColorRed200,
                    width: 6,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: PreMedColorTheme().neutral60,
                  radius: 20,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 28,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: submitOnboardingData,
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: PreMedColorTheme().bordercolor,
                    width: 6,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: PreMedColorTheme().primaryColorRed,
                  radius: 28,
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 34,
                    color: Colors.white,
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

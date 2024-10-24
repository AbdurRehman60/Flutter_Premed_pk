import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_theme.dart';
import '../../../constants/sized_boxes.dart';
import '../../../constants/text_theme.dart';
import '../../../models/boards_and_features_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/onboarding_provider.dart';
import '../../../providers/user_provider.dart';
import 'thankyou_screen.dart';

class ChooseFeatures extends StatefulWidget {
  const ChooseFeatures({super.key});

  @override
  State<ChooseFeatures> createState() => _ChooseFeaturesState();
}

class _ChooseFeaturesState extends State<ChooseFeatures> {
  final Set<int> _selectedIndexes = {};
  bool hasErrors = false;
  String error = "";
  Board? _selectedBoard;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final boardProvider = Provider.of<BoardProvider>(context, listen: false);
      boardProvider.fetchBoards();
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

  List<Map<String, dynamic>> getSelectedFeatures(Board selectedBoard) {
    return _selectedIndexes
        .map((index) => selectedBoard.tags[index].toJson())
        .toList();
  }

  Future<void> submitOnboardingData() async {
    if (_selectedBoard == null) {
      setState(() {
        error = 'Please select a board.';
        hasErrors = true;
      });
      showErrorDialog(error);
      return;
    }

    final List<Map<String, dynamic>> features = getSelectedFeatures(_selectedBoard!);
    if (features.isEmpty) {
      _showFeatureSelectionWarning();
      return;
    }

    final AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    final String? username = userProvider.user?.userName;
    if (username == null) {
      setState(() {
        error = 'Username not found. Please log in again.';
        hasErrors = true;
      });
      showErrorDialog(error);
      return;
    }

    final String boardName = _selectedBoard?.boardName ?? 'Unknown Board';


    final String featuresJson = jsonEncode(features);


    print('Selected Features JSON: $featuresJson');

    try {
      final result = await auth.requiredOnboarding(
        username: username,
        lastOnboardingPage: "/auth/onboarding/entrance-exam/pre-medical/additional-info/features",
        selectedExams: [boardName],
        selectedFeatures: features.map((e) => e['featureName'] as String).toList(),
      );

      if (result['status']) {
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

  void _showFeatureSelectionWarning() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("No Features Selected"),
          content: const Text(
              "Please select at least one feature to continue."),
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
    final username = UserProvider().user?.fullName;

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxes.verticalExtraGargangua,
                  RichText(
                    text: TextSpan(
                      style: PreMedTextTheme().subtext.copyWith(
                          color: PreMedColorTheme().black,
                          fontSize: 35,
                          fontWeight: FontWeight.w700),
                      children: [
                        const TextSpan(text: 'Hi, '),
                        WidgetSpan(
                          child: GradientText(
                            text: username ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                            ),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.purple,
                                PreMedColorTheme().primaryColorRed,
                              ],
                            ),
                          ),
                        ),
                        TextSpan(
                          text: '!',
                          style: PreMedTextTheme().subtext1.copyWith(
                              color: PreMedColorTheme().black,
                              fontWeight: FontWeight.w700,
                              fontSize: 35),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxes.verticalMicro,
                  RichText(
                    text: TextSpan(
                      style: PreMedTextTheme().subtext.copyWith(
                          color: PreMedColorTheme().black,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                      children: [
                        const TextSpan(text: 'What '),
                        TextSpan(
                          text: 'exam ',
                          style: PreMedTextTheme().heading3.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: PreMedColorTheme().primaryColorRed),
                        ),
                        TextSpan(
                          text: 'are you preparing for?',
                          style: PreMedTextTheme().subtext1.copyWith(
                            color: PreMedColorTheme().black,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, // Ensures ListView fits its content height
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: boards.length,
                    itemBuilder: (context, index) {
                      final board = boards[index];
                      final isSelected = _selectedBoard == board;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBoard = board;
                            _selectedIndexes.clear();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? PreMedColorTheme().primaryColorRed
                                  : const Color(0x80FFFFFF),
                              width: 4,
                            ),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            board.boardName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.redAccent
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBoxes.verticalMedium,
                  if (_selectedBoard != null) ...[
                    Text(
                      'Select features for ${_selectedBoard!.boardName}:',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBoxes.verticalMicro,
                    SizedBox(
                      height: 300, // Constraint ListView height
                      child: ListView.builder(
                        itemCount: _selectedBoard!.tags.length,
                        itemBuilder: (context, index) {
                          final feature = _selectedBoard!.tags[index];
                          final isSelected = _selectedIndexes.contains(index);

                          return GestureDetector(
                            onTap: () => _toggleSelection(index),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: isSelected
                                      ? PreMedColorTheme().primaryColorRed
                                      : const Color(0x80FFFFFF),
                                  width: 4,
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
                                  const SizedBox(width: 10),
                                  Text(
                                    feature.featureName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.black87,
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: Row(
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
                const SizedBox(width: 10),
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
        ],
      ),
    );
  }
}
class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}



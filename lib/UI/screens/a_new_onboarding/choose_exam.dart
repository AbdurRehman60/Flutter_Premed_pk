import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/choose_features.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import '../../../providers/user_provider.dart';

class ChooseExam extends StatefulWidget {
  const ChooseExam(
      {required this.lastOnboardingPage,
      required this.category,
        required this.city,
        required this.phoneNumber,
        required this.institution,
        required this.password,
        required this.educationSystem,
      super.key});
  final String educationSystem;
  final String password;
  final String lastOnboardingPage;
  final String category;
  final String city;
  final String phoneNumber;
  final String institution;

  @override
  State<ChooseExam> createState() => _ChooseExamState();
}

class _ChooseExamState extends State<ChooseExam> {
  Set<int> selectedContainerIndices = {};

  @override
  Widget build(BuildContext context) {
    final username = UserProvider().user?.fullName;

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxes.verticalGargangua,
              RichText(
                text: TextSpan(
                    style: PreMedTextTheme().subtext.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 35,
                        fontWeight: FontWeight.w700),
                    children: [
                      const TextSpan(
                        text: 'Hi, ',
                      ),
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
                    ]),
              ),
              SizedBoxes.verticalLarge,
              RichText(
                text: TextSpan(
                    style: PreMedTextTheme().subtext.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                    children: [
                      const TextSpan(
                        text: 'What ',
                      ),
                      TextSpan(
                          text: 'exam ',
                          style: PreMedTextTheme().heading3.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: PreMedColorTheme().primaryColorRed)),
                      TextSpan(
                        text: 'are you preparing for?',
                        style: PreMedTextTheme().subtext1.copyWith(
                              color: PreMedColorTheme().black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                            ),
                      ),
                    ]),
              ),
              SizedBoxes.vertical15Px,
              Text(
                "You can select more than one",
                style: PreMedTextTheme()
                    .body
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBoxes.vertical25Px,
              if (widget.category == 'pre-medical')
                _buildPreMedicalUI()
              else
                _buildPreEngineeringUI(),
            ],
          ),
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
                      color: PreMedColorTheme().primaryColorRed200, width: 6),
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
              onPressed: _onForwardPressed,
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: PreMedColorTheme().bordercolor, width: 6),
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

  void _onForwardPressed() {
    String selectedValue;

    if (widget.category == 'pre-engineering') {
      if (selectedContainerIndices.contains(0)) {
        selectedValue = "ALL IN ONE";
      } else {
        selectedValue = '';
      }
    } else {
      final examMapping = {
        0: 'MDCAT',
        1: 'NUMS',
        2: 'Private Universities',
      };

      List<String> selectedExams =
          selectedContainerIndices.map((index) => examMapping[index]!).toList();

      selectedExams.sort((a, b) {
        const order = ['MDCAT', 'NUMS', 'Private Universities'];
        return order.indexOf(a).compareTo(order.indexOf(b));
      });

      if (selectedExams.length == 3 ||
          (selectedExams.contains('NUMS') &&
              selectedExams.contains('Private Universities'))) {
        selectedValue = "ALL IN ONE";
      } else if (selectedExams.length == 2) {
        selectedValue = selectedExams.join(' + ');
      } else if (selectedExams.length == 1) {
        selectedValue = selectedExams.first;
      } else {
        selectedValue = '';
      }
    }
print("this is the last onbaording url on exam class ${widget.lastOnboardingPage}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseFeatures(
          lastOnboarding: widget.lastOnboardingPage,
          selectedExam: selectedValue,
          category: widget.category,
          password: widget.password,
          educationSystem: widget.educationSystem,
          phoneNumber: widget.phoneNumber,
          city: widget.city,
          institution: widget.institution,
        ),
      ),
    );
  }


  Widget _buildPreMedicalUI() {
    return Column(
      children: [
        Center(child: _buildExamContainer(0, PremedAssets.onboardingmdcat)),
        const SizedBox(height: 20),
        _buildExamContainer(1, PremedAssets.onboardingnums),
        const SizedBox(height: 20),
        _buildExamContainer(2, PremedAssets.onboardingpu),
      ],
    );
  }

  Widget _buildPreEngineeringUI() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedContainerIndices = {0};
        });
      },
      child: Center(
        child: Container(
          width: 280,
          height: 130,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedContainerIndices.contains(0)
                  ? PreMedColorTheme().primaryColorRed
                  : Colors.white.withOpacity(0.50),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(0, 20),
                blurRadius: 40,
              ),
            ],
          ),
          child: Center(
            child: Text(
              "All in one",
              style: PreMedTextTheme().heading3.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamContainer(int index, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedContainerIndices.contains(index)) {
            selectedContainerIndices.remove(index);
          } else {
            selectedContainerIndices.add(index);
          }
        });
      },
      child: Container(
        width: 280,
        height: 130,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedContainerIndices.contains(index)
                ? PreMedColorTheme().primaryColorRed
                : Colors.white.withOpacity(0.50),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 20),
              blurRadius: 40,
            ),
          ],
        ),
        child: Image.asset(imagePath),
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

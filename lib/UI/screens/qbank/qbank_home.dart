import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/expert_solution_home.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/saved_question/saved_question_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/mocks_bank.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/test_session.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/home_tile.dart';
import 'package:premedpk_mobile_app/pre_engineering/UI/screens/qbank/chapter_wise.dart';
import 'package:premedpk_mobile_app/pre_engineering/UI/screens/saved_question/saved_question_eng.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants_export.dart';
import '../../../pre_engineering/UI/screens/qbank/test_session.dart';
import '../Dashboard_Screen/dashboard_screen.dart';
import 'global_qbank.dart';

class QBankHome extends StatefulWidget {
  const QBankHome({super.key});

  @override
  State<QBankHome> createState() => _QBankHomeState();
}

class _QBankHomeState extends State<QBankHome> {
  Future<void> showComingSoonSnackbar(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Coming Soon!"),
          content: const Text(
              "We are working on this, come back later for updates."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final pro = context.watch<PreMedProvider>();
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'QBank',
                  style: PreMedTextTheme()
                      .body1
                      .copyWith(fontSize: 34, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBoxes.vertical5Px,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  pro.isPreMed
                      ? 'MDCAT, NUMS, and Private Universities Question Bank'
                      : 'NET, ECAT, FAST, and other engineering universities',
                  style: PreMedTextTheme()
                      .body1
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBoxes.vertical22Px,
              HomeTile(
                title: 'Chapter-Wise',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pro.isPreMed
                          ? const GlobalQbank(
                              isTopical: true,
                            )
                          : const EngChapterWiseHome(),
                    ),
                  );
                },
                imageAddress: PremedAssets.ChapterWise,
              ),
              SizedBoxes.vertical22Px,
              HomeTile(
                  title: 'Yearly Past Papers',
                  onTap: () {
                    pro.isPreMed
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GlobalQbank(
                                isTopical: false,
                              ),
                            ),
                          )
                        : showComingSoonSnackbar(context);
                  },
                  imageAddress: PremedAssets.PastPapers),
              SizedBoxes.vertical22Px,
              HomeTile(
                title: 'Self-Assessment Mocks',
                onTap: () {
                  pro.isPreMed
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MocksQbank()),
                        )
                      : showComingSoonSnackbar(context);
                },
                imageAddress: PremedAssets.Mocks,
              ),
              SizedBoxes.vertical22Px,
              HomeTile(
                title: 'Test Sessions',
                onTap: () {
                  pro.isPreMed
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MedTestSessionHome()))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EngTestSessionHome()));
                },
                imageAddress: PremedAssets.TestSession,
              ),
              SizedBoxes.vertical22Px,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: BankTilesLast(upperText: 'Video', lowerText: 'Solutions', onTap: () {
                      Navigator.of(context,).push(MaterialPageRoute(builder: (context)=> const ExpertSolutionHome()));
                    }, imageAddress: PremedAssets.videoSolution,)),
                    SizedBoxes.horizontal15Px,
                    Expanded(child: BankTilesLast(upperText: 'Saved', lowerText: 'Questions', onTap: () {
                      Navigator.of(context,).push(MaterialPageRoute(builder: (context)=> Provider.of<PreMedProvider>(context).isPreMed ? const SavedQuestionScreen() : const SavedQuestionScreenEng()));
                    }, imageAddress: PremedAssets.SavedQuestin,)),
                  ],
                ),
              ),
              SizedBoxes.vertical22Px,
            ],
          ),
        ),
      ),
    );
  }
}



class BankTilesLast extends StatelessWidget {
  const BankTilesLast({
    super.key,
    required this.upperText,
    required this.onTap,
    required this.imageAddress,
    required this.lowerText,
  });

  final String upperText;
  final String lowerText;
  final void Function() onTap;
  final String imageAddress;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(15),
          boxShadow: CustomBoxShadow.boxShadow40,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    imageAddress,
                    height: 26,
                    width: 30,
                  ),
                  SizedBoxes.horizontal10Px,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        upperText,
                        style: PreMedTextTheme().body1.copyWith(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: Provider.of<PreMedProvider>(context,listen: false).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                        ),
                      ),
                      Text(
                        lowerText,
                        style: PreMedTextTheme().body1.copyWith(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

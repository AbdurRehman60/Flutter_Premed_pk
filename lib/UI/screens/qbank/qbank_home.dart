import 'package:premedpk_mobile_app/UI/screens/qbank/mocks_bank.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/test_session.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/widgets/home_tile.dart';
import 'package:premedpk_mobile_app/pre_engineering/UI/screens/qbank/chapter_wise.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants_export.dart';
import '../../../pre_engineering/UI/screens/qbank/test_session.dart';
import 'global_qbank.dart';

class QBankHome extends StatefulWidget {
  const QBankHome({super.key});

  @override
  State<QBankHome> createState() => _QBankHomeState();
}

class _QBankHomeState extends State<QBankHome> {
  void showComingSoonSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Coming Soon'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final pro = context.watch<PreMedProvider>();
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'QBank',
                style: PreMedTextTheme()
                    .body1
                    .copyWith(fontSize: 34, fontWeight: FontWeight.w800),
              ),
              SizedBoxes.vertical5Px,
              Text(
                pro.isPreMed
                    ? 'MDCAT, NUMS, and Private Universities Question Bank'
                    : 'NET, ECAT, FAST, and other engineering universities',
                style: PreMedTextTheme()
                    .body1
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
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
              HomeTile(
                title: 'Saved Questions',
                onTap: () {},
                imageAddress: PremedAssets.SavedQuestin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

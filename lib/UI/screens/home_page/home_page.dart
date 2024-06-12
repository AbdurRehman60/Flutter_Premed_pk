import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/qbank_card.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/question_of_day_card.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/recentActivityCard.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/update_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF0F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBoxes.vertical2Px,
                    Text(
                      // 'Hi, ${userProvider.getUserName().split(' ').length > 1 ? '${userProvider.getUserName().split(' ').first} ${userProvider.getUserName().split(' ')[1]}' : userProvider.getUserName().split(' ').first}',
                      'Hi,Fateh',
                      style: PreMedTextTheme()
                          .heading4
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 28),
                    ),
                    Text(
                      'Ready to continue your journey?',
                      style: PreMedTextTheme().body.copyWith(fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 10),
                      child: Row(
                        children: [
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(20),
                            child: Qbank(
                              icon: PremedAssets.numsQbankLogo,
                              onTap: () {},
                              bgColor: PreMedColorTheme().white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(20),
                            child: Qbank(
                              icon: PremedAssets.MDCATQbankLogo,
                              onTap: () {},
                              bgColor: PreMedColorTheme().white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(20),
                            child: Qbank(
                              icon: PremedAssets.priQbankLogo,
                              onTap: () {},
                              bgColor: PreMedColorTheme().white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const QuestionCard(
                      question:
                          'What is the other name of the magnetic field intensity?',
                      tags: ['physics', 'Electromagnetism'],
                      isResource: false,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: RecentActivityCard(
                        acivityname: 'Alkyl Halides and Amines Past Paper',
                        date: '26th Feb 2024',
                        progressValue: 0.6,
                      ),
                    ),
                    const UpdateCard()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

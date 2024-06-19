import 'package:premedpk_mobile_app/UI/screens/expert_solution/expert_solution_home.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../../qbank/mdcat/mocks&bank_statistics.dart';
import '../../qbank/nums/mocks_or_bank.dart';
import '../../qbank/private_universities/pu_mock_or_bank_screen.dart';
import 'notes_tile.dart';

class QbankHome extends StatelessWidget {
  const QbankHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QBank',
              style: PreMedTextTheme().body.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: PreMedColorTheme().black),
            ),
            SizedBoxes.verticalLarge,
            Text(
              'MDCAT, NUMS, and Private Universities Question Bank',
              style: PreMedTextTheme()
                  .body
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            SizedBoxes.verticalGargangua,
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(15),
              child: NotesTileWithoutDescription(
                heading: "MDCAT",
                icon: PremedAssets.MDCAT,
                bgColor: PreMedColorTheme().white,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MDcatMockorBankStats(),
                    ),
                  );
                },
              ),
            ),
            SizedBoxes.vertical26Px,
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(15),
              child: NotesTileWithoutDescription(
                heading: "NUMS",
                icon: PremedAssets.NUMS,
                bgColor: PreMedColorTheme().white,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NumsorBankStats(),
                    ),
                  );
                },
              ),
            ),
            SizedBoxes.vertical26Px,
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(15),
              child: NotesTileWithoutDescription(
                heading: "Private\nUniversities",
                icon: PremedAssets.PU,
                bgColor: PreMedColorTheme().white,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PUmockorBankStats(),
                    ),
                  );
                },
              ),
            ),
            SizedBoxes.vertical26Px,
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExpertSolutionHome(),
                  ),
                );
              },
              child: Material(
                elevation: 4,
                child: Container(
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
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: PreMedColorTheme().white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          PremedAssets.Grad,
                          fit: BoxFit.contain,
                          width: 60,
                          height: 60,
                        ),
                        SizedBoxes.horizontalMedium,
                        Expanded(
                          child: Column(
                            children: [
                              SizedBoxes.horizontalMedium,
                              Align(
                                alignment: Alignment.centerLeft,
                               child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: PreMedTextTheme()
                                        .subtext
                                        .copyWith(fontWeight: FontWeight.w800,fontSize: 20,color: PreMedColorTheme().black),
                                    children: [
                                     TextSpan(
                                    text: 'Expert ',
                                      style: PreMedTextTheme()
                                          .subtext
                                          .copyWith(fontWeight: FontWeight.w800,fontSize: 20,color: PreMedColorTheme().primaryColorRed),

                                    ),
                                  const TextSpan(
                                    text: 'Solutions',
                                  ),
                                 ]
                               ),),
                              ),
                              SizedBoxes.horizontalBig,
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ExpertSolutionHome(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: PreMedColorTheme().primaryColorRed,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBoxes.verticalLarge,
          ],
        ),
      ),
    );
  }
}

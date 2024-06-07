import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/mdcat/mdcatMock.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import 'MdcatQbank.dart';
import '../widgets/stat_group_container.dart';

class MDcatMockorBankStats extends StatelessWidget {
  const MDcatMockorBankStats({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: 37,
              height: 37,
              child: SvgPicture.asset(
                'assets/icons/left-arrow.svg',
                width: 9.33,
                height: 18.67,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MDCAT',
                style: GoogleFonts.rubik(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBoxes.vertical3Px,
              Text(
                'Past Papers, Mocks and Original Practice Questions',
                style: GoogleFonts.rubik(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF000000),
                ),
              ),
              SizedBoxes.vertical26Px,
              QbankStatsContainer(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MDCATQbankHome()));
                },
                title: 'Question Bank',
                totalMcqs: '25K MCQs',
                completedPercentage: '100',
                MCQSDone: '2353',
                totalMCQS: '25000',
              ),
              SizedBoxes.vertical26Px,
              QbankStatsContainer(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MdcatMockHome()));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Qbank(
                  //             deckCategory: mockCategory,
                  //             deckGroupName: widget.deckGroupName)));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Qbank(
                  //             deckCategory: bankCategory,
                  //             deckGroupName: deckGroupName)));
                },
                title: 'Mocks',
                totalMcqs: '29 Mocks',
                completedPercentage: '100',
                MCQSDone: '2353',
                totalMCQS: '25000',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

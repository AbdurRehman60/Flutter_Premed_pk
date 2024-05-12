import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/qbank_ground.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/qbank_stats_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';




class QbanksStatsPage extends StatefulWidget {
  const QbanksStatsPage({super.key, required this.deckGroupName});
  final String deckGroupName;

  @override
  State<QbanksStatsPage> createState() => _QbanksStatsPageState();
}

class _QbanksStatsPageState extends State<QbanksStatsPage> {
  String bankCategory = '';
  String mockCategory = '';

  @override
  void initState() {
    super.initState();
    navigateWithBankorMock(widget.deckGroupName);
  }

  void navigateWithBankorMock(String deckGroupName) {
    if (deckGroupName == 'MDCAT QBANK') {
      setState(() {
        bankCategory = 'MDCAT QBank';
        mockCategory = 'MDCAT Mocks';
      });
    } else if (deckGroupName == 'NUMS QBANK') {
      setState(() {
        bankCategory = 'NUMS QBank';
        mockCategory = 'NUMS Mocks';
      });
    } else {
      setState(() {
        bankCategory = 'Private Universities QBank';
        mockCategory = 'Private Universities Mocks';
      });
    }
  }


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
                          builder: (context) => Qbank(
                              deckCategory: bankCategory,
                              deckGroupName: widget.deckGroupName)));
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
                          builder: (context) => Qbank(
                              deckCategory: mockCategory,
                              deckGroupName: widget.deckGroupName)));
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

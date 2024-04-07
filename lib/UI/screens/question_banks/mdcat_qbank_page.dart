import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/deck_info_container.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/sub_deck_container.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../providers/decks_provider.dart';

class MDCatQbankInterface extends StatefulWidget {
  const MDCatQbankInterface({super.key});

  @override
  State<MDCatQbankInterface> createState() => _MDCatQbankInterfaceState();
}

class _MDCatQbankInterfaceState extends State<MDCatQbankInterface> {
  bool yearly = true;
  @override
  Widget build(BuildContext context) {
    final deckPro = Provider.of<DecksProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
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
                'MDCAT QBank',
                style: GoogleFonts.rubik(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              SizedBoxes.vertical26Px,
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height: 45,
                  color: const Color(0xFFFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              yearly = true;
                              deckPro.changeDecktype();
                            });
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: yearly
                                ? BoxDecoration(
                                    color: const Color(0xFFEC5863),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0x80FFFFFF),
                                        width: 3),
                                  )
                                : const BoxDecoration(),
                            child: Center(
                              child: Text(
                                'YEARLY',
                                style: GoogleFonts.rubik(
                                    color: yearly
                                        ? const Color(0xFFFFFFFF)
                                        : const Color(0xFF000000),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              yearly = false;
                              deckPro.changeDecktype();
                            });
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: yearly
                                ? const BoxDecoration()
                                : BoxDecoration(
                                    color: const Color(0xFFEC5863),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0x80FFFFFF),
                                        width: 3),
                                  ),
                            child: Center(
                              child: Text(
                                'TOPICAL',
                                style: GoogleFonts.rubik(
                                    color: yearly
                                        ? const Color(0xFF000000)
                                        : const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBoxes.vertical26Px,
              Text(
                'Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!',
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: const Color(0xFF000000),
                  height: 1.3,
                ),
              ),
              SizedBoxes.vertical26Px,
              FutureBuilder(
                future: Provider.of<DecksProvider>(context, listen: false)
                    .fetchDecks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error fetching data'),
                    ); // Show error message
                  } else {
                    final Map<String, dynamic>? data = snapshot.data;
                    if (data != null && data['status'] == true) {
                      // Data loaded successfully
                      return Expanded(
                        child: ListView.builder(
                          itemCount: deckPro.deckList.length,
                          itemBuilder: (context, index) {
                            final deck = deckPro.deckList[index];
                            return DeckInfoContainer(
                                qbank: deck,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 15, 16, 0),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/rectangle.svg'),
                                          const SizedBox(
                                            height: 28,
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: deckPro.deckList[index]
                                                  .subDeckDetails.length,
                                              itemBuilder: (context, index) =>
                                                  SubDeckContainer(
                                                      details:
                                                          deck.subDeckDetails[
                                                              index],
                                                      onTap: () {}),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      );
                    } else {
                      // Data loading failed
                      return Center(
                        child: Text(data?['message'] ?? 'Error fetching data'),
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

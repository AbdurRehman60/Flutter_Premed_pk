import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/widgets/build_error.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/widgets/qbank_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/widgets/sub_bank_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/widgets/test_mode_page.dart';

import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/deck_model.dart';
import 'package:premedpk_mobile_app/providers/decks_provider.dart';
import 'package:provider/provider.dart';

class Qbank extends StatelessWidget {
  const Qbank(
      {super.key, required this.deckCategory, required this.deckGroupName});
  final String deckCategory;
  final String deckGroupName;
  @override
  Widget build(BuildContext context) {
    final deckPro = Provider.of<DecksProvider>(context, listen: false);
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
            child: const SizedBox(
              height: 37,
              width: 37,
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFEC5863),
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
                deckCategory,
                style: PreMedTextTheme()
                    .heading2
                    .copyWith(fontSize: 34, fontWeight: FontWeight.w800),
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
                            deckPro.getYearlyDecks();
                          },
                          child: Consumer<DecksProvider>(
                            builder: (context, decksProvider, _) => Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: decksProvider.changeColor
                                  ? BoxDecoration(
                                      color: const Color(0xFFEC5863),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0x80FFFFFF),
                                          width: 3),
                                    )
                                  : const BoxDecoration(),
                              child: Center(
                                child: Text('YEARLY',
                                    style: PreMedTextTheme().heading2.copyWith(
                                        color: decksProvider.changeColor
                                            ? const Color(0xFFFFFFFF)
                                            : const Color(0xFF000000),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            deckPro.getTopicalDecks();
                          },
                          child: Consumer<DecksProvider>(
                            builder: (context, decksProvider, _) => Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: decksProvider.changeColor
                                  ? const BoxDecoration()
                                  : BoxDecoration(
                                      color: const Color(0xFFEC5863),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0x80FFFFFF),
                                          width: 3),
                                    ),
                              child: Center(
                                child: Text('TOPICAL',
                                    style: PreMedTextTheme().heading2.copyWith(
                                        color: decksProvider.changeColor
                                            ? const Color(0xFF000000)
                                            : const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12)),
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
                style: PreMedTextTheme().heading2.copyWith(fontSize: 12),
              ),
              SizedBoxes.vertical26Px,
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: Provider.of<DecksProvider>(context, listen: false)
                      .fetchDecks(deckCategory),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoading(); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return buildError(); // Show error message
                    } else {
                      final Map<String, dynamic>? data = snapshot.data;
                      if (data != null && data['status'] == true) {
                        // Data loaded successfully
                        return _buildDecksList(Provider.of<DecksProvider>(
                          context,
                        ).deckList);
                      } else {
                        // Data loading failed
                        return buildError(message: data?['message']);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void pop(context) {
    Navigator.pop(context);
  }

  Widget _buildDecksList(List<DeckModel> deckList) {
    return ListView.builder(
      itemCount: deckList.length,
      itemBuilder: (context, index) {
        final deck = deckList[index];
        return QbankTile(
          qbank: deck,
          onTap: () {
            showModalBottomSheet(
              clipBehavior: Clip.hardEdge,
                context: context,
                builder: (context) => Container(
                  padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/icons/line.svg',width: 40,),
                          SizedBoxes.verticalMedium,
                          Expanded(
                            child: ListView.builder(
                                itemCount: deckList[index].subDeckDetails.length,
                                itemBuilder: (context, index) => SubBankTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TestModeInterface(
                                                    deckGroupName: deckGroupName,
                                                    deckDetails:
                                                        deck.subDeckDetails[index],
                                                  ))).then(
                                          (value) => Navigator.of(context).pop());
                                      // Navigator.of(context).pop();
                                    },
                                    details: deck.subDeckDetails[index])),
                          ),
                        ],
                      ),
                    ));
            // Handle tap event if needed
          },
        );
      },
    );
  }
}

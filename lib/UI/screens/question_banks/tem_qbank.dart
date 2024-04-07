import 'package:flutter/material.dart';

import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/customised_buttons/qbank_button_y.dart';
import 'package:premedpk_mobile_app/models/deck_model.dart';
import 'package:premedpk_mobile_app/providers/decks_provider.dart';
import 'package:provider/provider.dart';

class MdCatQbank extends StatefulWidget {
  const MdCatQbank({super.key});

  @override
  State<MdCatQbank> createState() => _MdCatQbankState();
}

class _MdCatQbankState extends State<MdCatQbank> {
  @override
  Widget build(BuildContext context) {
    final deckPro = Provider.of<DecksProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              ButtonRow(
                // onTopicalTap: () {
                //   setState(() {
                //     deckPro.changeDecktype();
                //   });
                // },
                // onYearlyTap: () {
                //   setState(() {
                //     deckPro.changeDecktype();
                //   });
                // },
              ),
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: Provider.of<DecksProvider>(context, listen: false)
                      .fetchDecks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildLoading(); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return _buildError(); // Show error message
                    } else {
                      final Map<String, dynamic>? data = snapshot.data;
                      if (data != null && data['status'] == true) {
                        // Data loaded successfully
                        return _buildDecksList(
                            Provider.of<DecksProvider>(context, listen: false)
                                .deckList);
                      } else {
                        // Data loading failed
                        return _buildError(message: data?['message']);
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

  Widget _buildDecksList(List<DeckModel> deckList) {
    return ListView.builder(
      itemCount: deckList.length,
      itemBuilder: (context, index) {
        final deck = deckList[index];
        return QbankTile(
          qbank: deck,
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  child: ListView.builder(
                      itemCount: deckList[index].subDeckDetails.length,
                      itemBuilder: (context, index) => SubBankTile(
                          onTap: () {},
                          details: deck.subDeckDetails[index])),
                ));
            // Handle tap event if needed
          },
        );
      },
    );
  }

  Widget _buildError({String? message}) {
    return Center(
      child: Text(message ?? 'Error fetching data'),
    );
  }
}

class QbankTile extends StatelessWidget {
  const QbankTile({Key? key, required this.qbank, required this.onTap})
      : super(key: key);

  final DeckModel qbank;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          tileColor: Colors.grey.shade200,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(qbank.deckGroupImage),
          ),
          title: Text(qbank.deckGrpName),
          subtitle: Text('${qbank.deckGroupLenght.toString()} Papers'),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class SubBankTile extends StatelessWidget {
  const SubBankTile({Key? key, required this.onTap, required this.details})
      : super(key: key);
  final Map<String, dynamic> details;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(details['deckLogo']),
        ),
        title: Text(details['deckName']),
        // subtitle: Text('${qbank.deckGroupLenght.toString()} Papers'),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.red,
        ),
      ),
    );
  }
}

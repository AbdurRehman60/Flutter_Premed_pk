import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/deck_model.dart';
import 'package:premedpk_mobile_app/providers/decks_provider.dart';
import 'package:provider/provider.dart';

class MdCatQbank extends StatelessWidget {
  const MdCatQbank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deckPro = Provider.of<DecksProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                deckPro.changeDecktype();
              },
              icon: Icon(Icons.place))
        ],
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: Provider.of<DecksProvider>(context, listen: false).fetchDecks(),
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
                  Provider.of<DecksProvider>(context, listen: false).deckList);
            } else {
              // Data loading failed
              return _buildError(message: data?['message']);
            }
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
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
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(qbank.deckGroupImage),
      ),
      title: Text(qbank.deckGrpName),
      subtitle: Text('${qbank.deckGroupLenght.toString()} Papers'),
    );
  }
}

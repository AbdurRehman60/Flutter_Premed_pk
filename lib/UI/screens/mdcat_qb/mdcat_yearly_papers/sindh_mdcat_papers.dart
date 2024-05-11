import 'package:http/http.dart' as http;
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class MDCAT_Papers_5 extends StatelessWidget {
  const MDCAT_Papers_5({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: PreMedColorTheme().white,
    body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxes.verticalTiny,
            Center(
              child: Image.asset(
                'assets/icons/Rectangle 35.png',
                width: 50,
                height: 50,
              ),
            ),
            SizedBoxes.verticalTiny,
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchMDCAT2023Decks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final deckData = snapshot.data!;
                    return ListView.builder(
                      itemCount: deckData.length,
                      itemBuilder: (context, index) {
                        final deck = deckData[index];
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: PreMedColorTheme().white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:PreMedColorTheme().white,
                                      backgroundImage: NetworkImage(deck['deckLogo']),
                                    ),
                                    SizedBoxes.verticalTiny,
                                    Expanded(
                                      child: ListTile(
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(deck['deckName'], style: PreMedTextTheme().heading5,),
                                            SizedBoxes.verticalTiny,
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: PreMedColorTheme().primaryColorBlue,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                "Free",
                                                style: TextStyle(color:PreMedColorTheme().white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: -180 * 3.141592653589793 / 180,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: PreMedColorTheme().primaryColorRed,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
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

Future<List<Map<String, dynamic>>> fetchMDCAT2023Decks() async {
  try {
    final response = await http.get(
      Uri.parse('https://prodapi.premed.pk/api/get-all-published-decks'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic>? categories = data['data'];
      if (categories != null) {
        final mdcatQBankCategory = categories.firstWhere(
              (category) => category['categoryName'] == 'MDCAT QBank',
          orElse: () => null,
        );
        if (mdcatQBankCategory != null) {
          final deckGroups = mdcatQBankCategory['deckGroups'] as List<dynamic>;
          if (deckGroups.isNotEmpty) {
            final mdcat2023DeckGroup = deckGroups.firstWhere(
                  (deckGroup) => deckGroup['deckGroupName'] == 'Sindh MDCAT',
              orElse: () => null,
            );
            if (mdcat2023DeckGroup != null) {
              final List<dynamic>? decks = mdcat2023DeckGroup['decks'];
              if (decks != null) {
                List<Map<String, dynamic>> deckData = [];
                for (var deck in decks) {
                  final String? deckName = deck['deckName'];
                  final String? deckLogo = deck['deckLogo'];
                  if (deckName != null && deckLogo != null) {
                    deckData.add({'deckName': deckName, 'deckLogo': deckLogo});
                  }
                }
                return deckData;
              }
            }
          }
        }
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  return [];
}
}

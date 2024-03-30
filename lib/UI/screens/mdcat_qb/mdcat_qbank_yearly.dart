import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/customised_buttons/qbank_button_y.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/balochistan_mdcat-papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/federal_mdcat_papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/kpk_mdcat_papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/mdcat_2022_papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/mdcat_2023_papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/national_mdcat_papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/punjab_mdcat_papers.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_yearly_papers/sindh_mdcat_papers.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class QbankYearly extends StatefulWidget {
  const QbankYearly({Key? key});

  @override
  State<QbankYearly> createState() => _QbankYearlyState();
}

class _QbankYearlyState extends State<QbankYearly> {
  List<Map<String, dynamic>>? mdcatQbankDecks;

  @override
  void initState() {
    super.initState();
    fetchMDCATQBankDecks();
  }

  Future<void> fetchMDCATQBankDecks() async {
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
            final deckGroups =
                mdcatQBankCategory['deckGroups'] as List<dynamic>;
            if (deckGroups.isNotEmpty) {
              List<Map<String, dynamic>> yearlyDecks = [];
              for (var deckGroup in deckGroups) {
                final deckType = deckGroup['deckType'];
                if (deckType == 'Yearly') {
                  // Extracting image URL along with other data
                  final Map<String, dynamic> deckInfo = {
                    'deckGroupImage': deckGroup['deckGroupImage'],
                    'deckGroupName': deckGroup['deckGroupName'],
                  };
                  yearlyDecks.add(deckInfo);
                }
              }
              setState(() {
                mdcatQbankDecks = yearlyDecks;
              });
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: PreMedColorTheme().black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
            color: PreMedColorTheme().white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "MDCAT QBANK",
                  style: PreMedTextTheme().heading6,
                ),
              ),
              ButtonRow(),
              SizedBoxes.verticalBig,
              Center(
                child: Text(
                    "Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!",
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().black)),
              ),
              SizedBox(height: 16),
              if (mdcatQbankDecks == null)
                Center(child: CircularProgressIndicator())
              else
                Column(
                  children: mdcatQbankDecks!.map((deckGroup) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                Widget destinationScreen;
                                if (deckGroup['deckGroupName'] ==
                                    'MDCAT 2023') {
                                  destinationScreen = MDCAT_Paper_1();

                                } else if (deckGroup['deckGroupName'] ==
                                    'MDCAT 2022') {
                                  destinationScreen = MDCAT_Paper_2();

                                } else if (deckGroup['deckGroupName'] ==
                                    'National MDCAT') {
                                  destinationScreen = MDCAT_PApers_3();

                                } else if (deckGroup['deckGroupName'] ==
                                    'Punjab MDCAT') {
                                  destinationScreen = MDCAT_Paper_4();

                                } else if (deckGroup['deckGroupName'] ==
                                    'Sindh MDCAT') {
                                  destinationScreen = MDCAT_Papers_5();

                                } else if (deckGroup['deckGroupName'] == 'KPK MDCAT') {
                                  destinationScreen = MDCAT_Papers_6();

                                } else if (deckGroup['deckGroupName'] ==
                                    'Federal MDCAT') {
                                  destinationScreen = MDCAT_Papers_7();

                                } else if (deckGroup['deckGroupName'] ==
                                    'Balochistan MDCAT') {
                                  destinationScreen = MDCAT_Papers_8();

                                } else {
                                  return SizedBox.shrink();
                                }
                                return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.75,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      child: destinationScreen,
                                    ),
                                  ),
                                );
                              },
                            );
                          },

                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: PreMedColorTheme().white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: PreMedColorTheme().white,
                                  backgroundImage: deckGroup
                                          .containsKey('deckGroupImage')
                                      ? NetworkImage(
                                          deckGroup['deckGroupImage'] as String)
                                      : AssetImage(
                                              'assets/images/MDCAT QBank 2.png')
                                          as ImageProvider<Object>?,
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      deckGroup['deckGroupName'] ??
                                          'Unknown Deck Group',
                                      style: PreMedTextTheme().heading6,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      deckGroup['paperCount'] != null
                                          ? '${deckGroup['paperCount']} Papers'
                                          : 'Unknown Papers',
                                      style: PreMedTextTheme().heading6,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Transform.rotate(
                                  angle: -180 * 3.141592653589793 / 180,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: PreMedColorTheme().primaryColorRed,
                                    ),
                                    onPressed: () {
                                      //Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


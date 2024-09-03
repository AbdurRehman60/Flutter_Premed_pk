import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/color_theme.dart';
import '../../../../models/statistic_model.dart';
import '../../../../providers/statistic_provider.dart';
import '../../../../providers/vaultProviders/premed_provider.dart';
import '../../statistics/statistics_screen.dart';
import '../../statistics/widgets/Attempted_card.dart';
import '../../statistics/widgets/card_w.dart';
import '../dashboard_screen.dart';

class StatisticCard extends StatefulWidget {
  const StatisticCard({super.key});

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  late UserStatModel userStatModel;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final UserStatProvider userStatProvider =
    Provider.of<UserStatProvider>(context, listen: false);
    userStatProvider.fetchUserStatistics(context);
    return Container(
      width: screenWidth * 7,
      height: screenHeight * 0.32,
      decoration: BoxDecoration(
        color: PreMedColorTheme().white85,
        borderRadius: BorderRadius.circular(15),
        boxShadow: CustomBoxShadow.boxShadow40,
      ),
      child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 10),
          child: FutureBuilder(
            future: userStatProvider.fetchUserStatistics(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.connectionState ==
                  ConnectionState.done) {
                if (userStatProvider.userStatModel == null) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              Provider.of<PreMedProvider>(context,listen: false)
                                  .isPreMed
                                  ? PremedAssets.graph
                                  : PremedAssets.BlueGraph,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 2, bottom: 7),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Statistics",
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Check out your performance at a glance!",
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.08),
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              Provider.of<PreMedProvider>(context,listen: false)
                                  .isPreMed
                                  ? PremedAssets.arrow
                                  : PremedAssets.blueAerrow,
                              width: 15,
                              height: 15,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: screenHeight * 0.18,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(20),
                            boxShadow:
                            CustomBoxShadow.boxShadow40,
                          ),
                          child: MaterialCard(
                            height: screenHeight * 0.18,
                            width: screenWidth,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    StatDetailHolder(
                                      textColor:
                                      PreMedColorTheme()
                                          .greenLight,
                                      count: 0,
                                      details: 'Decks\nAttempted',
                                    ),
                                    StatDetailHolder(
                                      textColor:
                                      PreMedColorTheme().red,
                                      count: 0,
                                      details: 'Test\nAttempted',
                                    ),
                                    StatDetailHolder(
                                      textColor:
                                      PreMedColorTheme()
                                          .yellowlight,
                                      count: 0,
                                      details:
                                      'Practice Tests\nAttempted',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                userStatModel = userStatProvider.userStatModel!;
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            Provider.of<PreMedProvider>(context,listen: false)
                                .isPreMed
                                ? PremedAssets.graph
                                : PremedAssets.BlueGraph,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 2, bottom: 7),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Statistics",
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Check out your performance at a glance!",
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.08),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                const StatisticsScreen(),
                              ),
                            );
                          },
                          child: Image.asset(
                            Provider.of<PreMedProvider>(context,listen: false)
                                .isPreMed
                                ? PremedAssets.arrow
                                : PremedAssets.blueAerrow,
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: screenHeight * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: CustomBoxShadow.boxShadow40,
                        ),
                        child: MaterialCard(
                          height: screenHeight * 0.18,
                          width: screenWidth,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  StatDetailHolder(
                                    textColor: PreMedColorTheme()
                                        .greenLight,
                                    count: userStatModel
                                        .decksAttempted,
                                    details: 'Decks\nAttempted',
                                  ),
                                  StatDetailHolder(
                                    textColor:
                                    PreMedColorTheme().red,
                                    count:
                                    userStatModel.testAttempted,
                                    details: 'Test\nAttempted',
                                  ),
                                  StatDetailHolder(
                                    textColor: PreMedColorTheme()
                                        .yellowlight,
                                    count: userStatModel
                                        .paracticeTestAttempted,
                                    details:
                                    'Practice Tests\nAttempted',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset(
                            Provider.of<PreMedProvider>(context,listen: false)
                                .isPreMed
                                ? PremedAssets.graph
                                : PremedAssets.BlueGraph,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 2, bottom: 7),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Statistics",
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Check out your performance at a glance!",
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.08),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            Provider.of<PreMedProvider>(context,listen: false)
                                .isPreMed
                                ? PremedAssets.arrow
                                : PremedAssets.blueAerrow,
                            width: 15,
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: screenHeight * 0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: CustomBoxShadow.boxShadow40,
                        ),
                        child: MaterialCard(
                          height: screenHeight * 0.18,
                          width: screenWidth,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  StatDetailHolder(
                                    textColor: PreMedColorTheme()
                                        .greenLight,
                                    count: 0,
                                    details: 'Decks\nAttempted',
                                  ),
                                  StatDetailHolder(
                                    textColor:
                                    PreMedColorTheme().red,
                                    count: 0,
                                    details: 'Test\nAttempted',
                                  ),
                                  StatDetailHolder(
                                    textColor: PreMedColorTheme()
                                        .yellowlight,
                                    count: 0,
                                    details:
                                    'Practice Tests\nAttempted',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }
}

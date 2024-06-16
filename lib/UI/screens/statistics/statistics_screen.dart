// ignore: file_namessf

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/statistics_w.dart';

import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFBF0F3),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        ),
        body: SafeArea(child: SingleChildScrollView(
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.02), // 2% of screen height
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Statistics",
                          style: PreMedTextTheme().heading4.copyWith(
                              fontWeight: FontWeight.w800, fontSize: 28),
                        ),
                        Text(
                          'Your performance, facts and figures, all at a glance!',
                          style: PreMedTextTheme().body.copyWith(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )));
  }
}

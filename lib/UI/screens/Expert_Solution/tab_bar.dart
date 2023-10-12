import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(indicatorColor: PreMedColorTheme().primaryColorBlue, tabs: [
              Tab(
                child: Text(
                  'Solved Question',
                  style: PreMedTextTheme()
                      .subtext
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
                ),
              ),
              Tab(
                child: Text(
                  'Pending Question',
                  style: PreMedTextTheme()
                      .subtext
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

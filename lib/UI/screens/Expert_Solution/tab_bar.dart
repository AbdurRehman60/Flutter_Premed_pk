import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: TabBar(
              indicatorColor: PreMedColorTheme().white,
              tabs: [
                Tab(
                  child: Text(
                    'Solved Questions',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pending Questions',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

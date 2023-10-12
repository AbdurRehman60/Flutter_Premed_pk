import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.withOpacity(0.1),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(tabs: [
                Tab(
                  child: Text(
                    'Solved Question',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pending Question',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().black),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/export.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      collapsedHeight: 170,
      pinned: true,
      floating: true,
      expandedHeight: 160,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        centerTitle: true,
        titlePadding: EdgeInsets.zero, // Remove title padding
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Centered title
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(PremedAssets.EsIcon),
                SizedBoxes.horizontalMedium,
                Text(
                  'Expert Solution',
                  style: PreMedTextTheme()
                      .heading5
                      .copyWith(color: PreMedColorTheme().white),
                ),
              ],
            ),
            SizedBoxes.verticalBig,
            Text(
              'Get top-notch video solution answers to your MDCAT questions from top-merit experts',
              style: PreMedTextTheme()
                  .subtext
                  .copyWith(color: PreMedColorTheme().white),
              textAlign: TextAlign.center,
            ),
            SizedBoxes.verticalBig,
            // CustomTabBar(),
          ],
        ),
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(
                  20), // Set the top radius for the rounded rectangle
            ),
            gradient: PreMedColorTheme().primaryGradient,
          ),
        ),
      ),
    );
  }
}

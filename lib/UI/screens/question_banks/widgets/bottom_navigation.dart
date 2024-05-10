import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/ask_an_expert.dart';
import 'package:premedpk_mobile_app/UI/screens/account/account.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/qbank_homepage.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/recent_activity_page.dart';
import '../../../../constants/assets.dart';

class QbankBottomNavigation extends StatefulWidget {
  const QbankBottomNavigation({super.key});

  @override
  State<QbankBottomNavigation> createState() => _QbankBottomNavigationState();
}

class _QbankBottomNavigationState extends State<QbankBottomNavigation> {
  int myIndex = 0;
  List<Widget> screens = [
    const QbankHomePage(),
    const RecentActivityPage(),
    const AskanExpert(),
    const MarketPlace(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        selectedFontSize: 8,
        selectedItemColor: Colors.black,
        selectedLabelStyle:
            GoogleFonts.rubik(fontWeight: FontWeight.w500, height: 1.3),
        unselectedFontSize: 8,
        unselectedItemColor: const Color(0x80000000),
        unselectedLabelStyle:
            GoogleFonts.rubik(fontWeight: FontWeight.w400, height: 1.3),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PremedAssets.Dashboard),
            label: 'Dashboard',
            activeIcon: SvgPicture.asset(
              PremedAssets.Dashboard,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFEC5863), BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PremedAssets.QbankNav),
            label: 'Qbank',
            activeIcon: SvgPicture.asset(
              PremedAssets.QbankNav,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFEC5863), BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PremedAssets.ExpertSolutions),
            label: 'Expert Solutions',
            activeIcon: SvgPicture.asset(
              PremedAssets.ExpertSolutions,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFEC5863), BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PremedAssets.Shop),
            label: 'Shop',
            activeIcon: SvgPicture.asset(
              PremedAssets.Shop,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFEC5863), BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(PremedAssets.Settings),
            label: 'Settings',
            activeIcon: SvgPicture.asset(
              PremedAssets.Settings,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFEC5863), BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

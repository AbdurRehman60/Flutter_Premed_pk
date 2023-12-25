import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/account/account.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/expert_solution_home.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/home/homescreen.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/bottom_nav.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String dsrID = prefs.getString("userName") ?? '';

    return dsrID;
  }

  List<int> navigationStack = [0]; // Initialize with the home screen index

  final screens = [
    const HomeScreen(),
    const FlashcardHome(),
    const ExpertSolutionHome(),
    const MarketPlace(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigationStack.length > 1) {
          navigationStack.removeLast();
          int previousIndex = navigationStack.last;
          setState(() {
            navigationStack.removeLast();
            navigationStack.add(previousIndex);
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: screens[navigationStack.last],
        bottomNavigationBar: PremedBottomNav(
          currentIndex: navigationStack.last,
          onTapHome: () => onTap(0),
          onTapFlashcards: () => onTap(1),
          onTapExpertSolution: () => onTap(2),
          onTapMarketplace: () => onTap(3),
          onTapProfile: () => onTap(4),
        ),
      ),
    );
  }

  void onTap(int index) {
    final int currentIndex = navigationStack.last;
    if (currentIndex != index) {
      setState(() {
        navigationStack.remove(index);
        navigationStack.add(index);
      });
    }
  }
}

import 'package:premedpk_mobile_app/UI/screens/account/account.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/expert_solution_home.dart';
import 'package:premedpk_mobile_app/UI/screens/home/homescreen.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_home.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/bottom_nav.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/user_provider.dart';
import '../Login/login_screen_one.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String dsrID = prefs.getString("userName") ?? '';

    return dsrID;
  }

  List<int> navigationStack = [0];

  final screens = [
    const HomeScreen(),
    const MDCAT(),
    const ExpertSolutionHome(),
    const MarketPlace(),
    const Account(),
  ];

  void showLoginPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Required"),
          content: const Text("To use this feature, you need to log in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:  Text("Cancel", style: PreMedTextTheme().body.copyWith(
                color: PreMedColorTheme().primaryColorRed,

              ),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(PreMedColorTheme().primaryColorRed),
                foregroundColor: MaterialStateProperty.all<Color>(PreMedColorTheme().white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text("Login"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigationStack.length > 1) {
          navigationStack.removeLast();
          final int previousIndex = navigationStack.last;
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
          onTapQbank: () => onTap(1),
          onTapExpertSolution: () => onTap(2),
          onTapMarketplace: () => onTap(3),
          onTapProfile: () => onTap(4),
        ),
      ),
    );
  }

  Future<bool> checkIfUserLoggedIn() async {
    final UserProvider userProvider = UserProvider();
    return userProvider.isLoggedIn();
  }

  void onTap(int index) async {
    if (index == 4) {
      final isLoggedIn = await checkIfUserLoggedIn();
      if (isLoggedIn) {
        navigateTo(index);
      } else {
        showLoginPopup();
      }
    } else if (index == 1) {
      launchUrl(
        mode: LaunchMode.inAppBrowserView,
        Uri.parse("https://premed.pk/dashboard"),
      );
    } else {
      navigateTo(index);
    }
  }

  void navigateTo(int index) {
    final int currentIndex = navigationStack.last;
    if (currentIndex != index) {
      setState(() {
        navigationStack.remove(index);
        navigationStack.add(index);
      });
    }
  }
}
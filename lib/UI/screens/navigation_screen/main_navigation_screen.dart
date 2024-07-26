import 'package:premedpk_mobile_app/UI/screens/The%20vault/pre_eng/screens/pre_eng_vault_home.dart';
import 'package:premedpk_mobile_app/UI/screens/account/account.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/dashboard_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_home.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/bottom_nav.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    const DashboardSwitcher(),
    const MDCAT(),
    const VaultSwitcher(),
    const MarketPlace(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
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
          ontapVault: () => onTap(2),
          onTapMarketplace: () => onTap(3),
          onTapProfile: () => onTap(4),
        ),
      ),
    );
  }

  Future<void> onTap(int index) async {
    if (index == 1) {
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

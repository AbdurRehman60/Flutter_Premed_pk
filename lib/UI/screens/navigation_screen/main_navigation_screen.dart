import 'package:crypto/crypto.dart';
import 'package:premedpk_mobile_app/UI/screens/account/account.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/bottom_nav.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/qbank_home.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/user_provider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key,this.userPassword});
  final String? userPassword;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  @override
  void initState() {
    checkUserDetails(context);
    super.initState();
  }

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String dsrID = prefs.getString("userName") ?? '';
    return dsrID;
  }

  Future<void> checkUserDetails(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String? lastOnBoardingPage = userProvider.user?.info.lastOnboardingPage;

    if (lastOnBoardingPage != null) {
      if (lastOnBoardingPage.contains('auth/onboarding/flow/entrance-exam/pre-engineering')) {
        final preMedProvider = Provider.of<PreMedProvider>(context, listen: false);
        preMedProvider.setonBoardingTrack(false);
        preMedProvider.setPreMed(false);
      } else {
        final preMedProvider = Provider.of<PreMedProvider>(context, listen: false);
        preMedProvider.setonBoardingTrack(true);
      }
    }
  }

  List<int> navigationStack = [0];

  final screens = [
    const DashboardSwitcher(),
    const QBankHome(),
    const VaultSwitcher(),
    const MarketPlace(),
    const Account(),
  ];

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _launchURL(String appToken) async {
    final url = 'https://premed.pk/app-redirect?url=$appToken&&route="pricing/all"';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String appToken = userProvider.user?.info.appToken ?? '';

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
          onTapMarketplace: () => _launchURL(appToken),
          onTapProfile: () => onTap(4),
        ),
      ),
    );
  }

  Future<void> onTap(int index) async {
    navigateTo(index);
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

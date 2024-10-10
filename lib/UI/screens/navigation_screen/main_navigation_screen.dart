import 'package:crypto/crypto.dart';
import 'package:premedpk_mobile_app/UI/screens/account/account.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/bottom_nav.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/qbank_home.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/vaultProviders/premed_provider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, this.userPassword});
  final String? userPassword;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  List<int> navigationStack = [0]; // Keeps track of active tabs

  final screens = [
    const DashboardSwitcher(),
    const QBankHome(),
    const VaultSwitcher(),
    const MarketPlace(),
    const Account(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserDetails(context);
    });
  }

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String dsrID = prefs.getString("userName") ?? '';
    return dsrID;
  }

  Future<void> checkUserDetails(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String? lastOnBoardingPage =
        userProvider.user?.info.lastOnboardingPage;
    print('page: $lastOnBoardingPage');
    final bool userTrack =
        Provider.of<PreMedProvider>(context, listen: false).isPreMed;
    print('usersTrack:$userTrack');
    if (lastOnBoardingPage != null) {
      if (lastOnBoardingPage
          .contains('auth/onboarding/flow/entrance-exam/pre-engineering') &&
          !userTrack) {
        print('condition1');
        final preMedProvider =
        Provider.of<PreMedProvider>(context, listen: false);
        preMedProvider.setonBoardingTrack(false);
        preMedProvider.setPreMed(false);
      } else {
        print('condition3');
        final preMedProvider =
        Provider.of<PreMedProvider>(context, listen: false);
        preMedProvider.setonBoardingTrack(true);
      }
    }
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _launchURL(String appToken) async {
    // Use listen: false to avoid rebuilds in this context
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String lastonboarding = userProvider.user!.info.lastOnboardingPage;

    // Check if the lastonboarding URL contains "pre-medical" to decide the bundle path
    String bundlePath;
    if (lastonboarding.contains("pre-medical")) {
      bundlePath = "/bundles/mdcat";
    } else {
      bundlePath = "/bundles/all-in-one";
    }

    // Generate the final URL based on the condition
    final url = 'https://premed.pk/app-redirect?url=$appToken&&route=$bundlePath';

    // Try to launch the URL
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
        if (navigationStack.length == 1) {
          // If there's only one screen in the stack, allow the back button to exit the app
          return true;
        } else {
          // Go back to the previous screen in the stack
          setState(() {
            navigationStack.removeLast();
          });
          return false; // Prevent default back button behavior (which would pop the screen)
        }
      },
      child: Scaffold(
        body: screens[navigationStack.last], // Display the active screen
        bottomNavigationBar: PremedBottomNav(
          currentIndex: navigationStack.last, // Highlight the correct tab
          onTapHome: () => onTap(0),
          onTapQbank: () => onTap(1),
          ontapVault: () => onTap(2),
          onTapMarketplace: () => _launchURL(appToken),
          onTapProfile: () => onTap(4),
        ),
      ),
    );
  }


  void onTap(int index) {
    if (navigationStack.last != index) {
      setState(() {
        navigationStack.add(index); // Add the new tab index to the stack
      });
    }
  }
}
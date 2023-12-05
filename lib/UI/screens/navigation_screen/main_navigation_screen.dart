import 'package:premedpk_mobile_app/UI/screens/expert_solution/expert_solution_home.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/home/homescreen.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/bottom_nav.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dsrID = prefs.getString("userName") ?? '';

    return dsrID;
  }

  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    FlashcardHome(),
    const MarketPlace(),
    const ExpertSolutionHome(),
    const RevisionNotes(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: PremedBottomNav(
        currentIndex: currentIndex,
        onTapHome: onTapHome,
        onTapFlashcards: onTapFlashcards,
        onTapMarketplace: onTapMarketplace,
        onTapExpertSolution: onTapExpertSolution,
        onTapProfile: onTapProfile,
      ),
    );
  }

  void onTapHome() {
    currentIndex = 0;
    setState(() {});
  }

  void onTapFlashcards() {
    currentIndex = 1;
    setState(() {});
  }

  void onTapMarketplace() {
    currentIndex = 2;
    setState(() {});
  }

  void onTapExpertSolution() {
    currentIndex = 3;
    setState(() {});
  }

  void onTapProfile() {
    currentIndex = 4;
    setState(() {});
  }
}


// appBar: AppBar(
//         title: FutureBuilder<String>(
//           future: getUsername(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return const Text('Error fetching username');
//             } else {
//               return Text('Welcome, ${snapshot.data}');
//             }
//           },
//         ),
//       ),
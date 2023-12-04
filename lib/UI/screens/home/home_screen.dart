import 'package:premedpk_mobile_app/UI/screens/expert_solution/expert_solution_home.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dsrID = prefs.getString("userName") ?? '';

    return dsrID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: getUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error fetching username');
            } else {
              return Text('Welcome, ${snapshot.data}');
            }
          },
        ),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExpertSolutionHome(),
                ),
              );
            },
            child: const Text('Expert Solution'),
          ),
          // ... other buttons ...
        ],
      ),
    );
  }
}

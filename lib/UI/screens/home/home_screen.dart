import 'package:premedpk_mobile_app/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(children: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpertSolutionHome(),
              ),
            );
          },
          child: Text('Expert Solution'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const ProvincialGuides(),
              ),
            );
          },
          child: Text('Provincial Guides'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const RevisionNotes(),
              ),
            );
          },
          child: Text('Study Notes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FlashcardHome(),
              ),
            );
          },
          child: Text('Flash Cards'),
        ),
      ]),
    );
  }
}

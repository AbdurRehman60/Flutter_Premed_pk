import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Use Provider.of<FlashcardProvider>(context) to access the FlashcardProvider
    NotesProvider notesProvider =
        Provider.of<NotesProvider>(context, listen: true);

    onpressed() async {
      Map<String, dynamic> response = await notesProvider.fetchNotes();
      if (response.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RevisionNotes(),
          ),
        );
      } else {
        showError(context, response as Map<String, dynamic>);
      }
    }

    onguidespressed() async {
      // Create an instance of GuidesProvider

      Map<String, dynamic> response = await notesProvider.fetchGuides();
      if (response.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProvincialGuides(),
          ),
        );
      } else {
        showError(context, response as Map<String, dynamic>);
      }
    }

    FlashcardProvider flashcardProvider =
        Provider.of<FlashcardProvider>(context);

    onflashcardspressed() {
      final Future<Map<String, dynamic>> response =
          flashcardProvider.getFlashcardsByUser(email: "ddd@gmail.com");
      response.then((response) {
        if (response.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlashcardHome(),
            ),
          );
        } else {
          // Handle the error or show an error dialog
          showError(context, response as Map<String, dynamic>);
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonText: 'Fetch Notes',
              onPressed: onpressed,
            ),
            SizedBoxes.verticalExtraGargangua,
            CustomButton(
              buttonText: 'Fetch Guides',
              onPressed: onguidespressed,
            ),
            SizedBoxes.verticalExtraGargangua,
            CustomButton(
              buttonText: 'Fetch Flashcards',
              onPressed: onflashcardspressed,
            ),
            SizedBoxes.verticalExtraGargangua,
            CustomButton(
              buttonText: 'Expert Solution',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpertSolutionHome(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Provider.of<FlashcardProvider>(context) to access the FlashcardProvider
    NotesProvider notesProvider =
        Provider.of<NotesProvider>(context, listen: true);

    onpressed() async {
      Map<String, dynamic> response = await notesProvider.fetchNotes();
      if (response['status']) {
        // Data fetched successfully, you can access it from notesProvider.dataList
        print("Notes fetched successfully: ${notesProvider.dataList}");

        // Add your navigation logic here
      } else {
        // Handle the error or show an error dialog
        print("Failed to fetch notes: ${response['message']}");
      }
    }

    return Scaffold(
      body: Center(
        child: CustomButton(
          buttonText: 'Fetch Flashcards',
          onPressed: onpressed,
        ),
      ),
    );
  }
}

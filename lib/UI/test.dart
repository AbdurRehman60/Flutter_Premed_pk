import 'package:premedpk_mobile_app/UI/Widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/repository/flashcard_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Provider.of<FlashcardProvider>(context) to access the FlashcardProvider
    FlashcardProvider flashcardProvider =
        Provider.of<FlashcardProvider>(context);

    onpressed() {
      final Future<Map<String, dynamic>> response =
          flashcardProvider.getFlashcardsByUser(email: "ddd@gmail.com");
      response.then((response) {
        if (response.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlashcardScreen(),
            ),
          );
        } else {
          // Handle the error or show an error dialog
          showError(context, response as Map<String, dynamic>);
        }
      });
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

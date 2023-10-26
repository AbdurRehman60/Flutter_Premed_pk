import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/repository/notes_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotesProvider guidesProvider = Provider.of<NotesProvider>(context);
    onpressed() {
      final Future<Map<String, dynamic>> response = guidesProvider.fetchNotes();

      response.then(
        (response) {
          if (response['status']) {
            // User user = response['user'];

            // Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          } else {
            showError(context, response);
          }
          // Add this line to print status code
        },
      );
    }

    return Scaffold(
      body: Center(
          child: CustomButton(
        buttonText: 'buttonText',
        onPressed: onpressed,
      )),
    );
  }
}

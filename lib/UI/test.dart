import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/repository/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/repository/notes_provider.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AskAnExpertProvider guidesProvider =
        Provider.of<AskAnExpertProvider>(context);
    onpressed() {
      final Future<Map<String, dynamic>> response =
          guidesProvider.getDoubts(email: "ddd@gmail.com");

      response.then(
        (response) {
          if (response['status']) {
            // User user = response['user'];

            // Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpertSolutionHome(),
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

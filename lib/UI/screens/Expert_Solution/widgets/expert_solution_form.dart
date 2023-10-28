import 'dart:io';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/local_image_display.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

import 'package:premedpk_mobile_app/export.dart';

import '../../../../repository/expert_solution_provider.dart';

class ExpertSolutionForm extends StatelessWidget {
  final File? image;

  ExpertSolutionForm({
    Key? key,
    this.image,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(context);

    TextEditingController emailController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    void onSubmitPressed() {
      final form = _formKey.currentState;
      if (form!.validate()) {
        final Map<String, dynamic> askAnExpertData = {
          'username': emailController.text,
          'description': descriptionController.text,
          // 'subject': SubjectList,
          // 'topic': TopicList,
          // 'resource': ResourceList,
          'testImage': image,
        };

        final Future<Map<String, dynamic>> response =
            askAnExpertProvider.askanexpert(
          username: askAnExpertData['username'],
          description: askAnExpertData['description'],
          subject: askAnExpertData['subject'],
          topic: askAnExpertData['topic'],
          resource: askAnExpertData['resource'],
          testImage: askAnExpertData['testImage'],
        );

        response.then((response) {
          if (response['status']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpertSolutionHome(),
              ),
            );
          } else {
            showError(context, response);
          }
        });
      }
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Colors.white, // Customize as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: image != null
                        ? Expanded(
                            child: Image.file(image!),
                          )
                        : LocalImageDisplay(), // Implement LocalImageDisplay
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const OrDivider(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomButton(
                    buttonText: 'Open Camera & Take Photo',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  const Text(
                    'What problems are you facing in the uploaded question above? *',
                    style: TextStyle(
                      fontSize: 16, // Adjust as needed
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    maxLines: 6,
                    hintText: 'Enter questions here',
                  ),
                  SizedBoxes.verticalExtraGargangua,
                  CustomResourceDropDown(),
                  // SubjectList(),
                  SizedBoxes.verticalBig,
                  CustomButton(
                    buttonText: 'Submit',
                    onPressed: onSubmitPressed,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

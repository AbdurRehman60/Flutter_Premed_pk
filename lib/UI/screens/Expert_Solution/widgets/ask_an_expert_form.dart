import 'package:premedpk_mobile_app/UI/screens/expert_solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/local_image_display.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/dropdown_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/utils/validators.dart';
import 'package:provider/provider.dart';

import '../../../widgets/global_widgets_export.dart';

class AskanExpertForm extends StatelessWidget {
  AskanExpertForm({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(context);

    TextEditingController descriptionController = TextEditingController();

    void onSubmitPressed() {
      final form = _formKey.currentState!;
      if (askAnExpertProvider.uploadedImage == null) {
        showError(context, {"message": "Please upload an Image"});
        return;
      }
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
            askAnExpertProvider.uploadDoubt(
          email: "ddd@gmail.com",
          description: descriptionController.text,
          subject: askAnExpertProvider.selectedSubject,
          topic: askAnExpertProvider.selectedTopic,
          resource: askAnExpertProvider.selectedResource,
          testImage: askAnExpertProvider.uploadedImage!,
        );

        response.then((response) {
          if (response['status']) {
            showSnackbar(
              context,
              response['message'],
              SnackbarType.SUCCESS,
              navigate: true,
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
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: PreMedColorTheme()
                          .primaryColorBlue100, // Customize as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: askAnExpertProvider.uploadedImage != null
                        ? Image.file(
                            askAnExpertProvider.uploadedImage!,
                            fit: BoxFit.fitHeight,
                          )
                        : LocalImageDisplay(), // Implement LocalImageDisplay
                  ),
                  SizedBoxes.verticalLarge,
                  const OrDivider(),
                  SizedBoxes.verticalLarge,
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
                  SizedBoxes.verticalBig,
                  const CustomResourceDropDown(),
                  SizedBoxes.verticalBig,
                  const Text(
                    'What problems are you facing in the uploaded question above?',
                    style: TextStyle(
                      fontSize: 16, // Adjust as needed
                    ),
                  ),
                  SizedBoxes.verticalTiny,
                  CustomTextField(
                    controller: descriptionController,
                    maxLines: 6,
                    hintText: 'Enter questions here',
                    validator: (value) =>
                        validateIsNotEmpty(value, "Description"),
                  ),
                  SizedBoxes.verticalBig,
                  CustomButton(
                    buttonText: 'Submit',
                    onPressed: onSubmitPressed,
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

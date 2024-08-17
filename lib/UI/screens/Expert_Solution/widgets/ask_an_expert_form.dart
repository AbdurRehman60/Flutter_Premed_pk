import 'package:premedpk_mobile_app/UI/screens/expert_solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/local_image_display.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/dropdown_form.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/utils/validators.dart';
import 'package:provider/provider.dart';

import '../../../../providers/vaultProviders/premed_provider.dart';

class AskanExpertForm extends StatelessWidget {
  AskanExpertForm({
    super.key,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(context);
    final uplaodImageProvider = Provider.of<UplaodImageProvider>(context);
    final TextEditingController descriptionController = TextEditingController();

    void onSubmitPressed() {
      final form = _formKey.currentState!;
      if (uplaodImageProvider.uploadedImage == null) {
        showError(context, {"message": "Please upload an Image"});
        return;
      }
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
            askAnExpertProvider.uploadDoubt(
          description: descriptionController.text,
          subject: askAnExpertProvider.selectedSubject,
          topic: askAnExpertProvider.selectedTopic,
          resource: askAnExpertProvider.selectedResource,
          testImage: uplaodImageProvider.uploadedImage!,
        );

        response.then((response) {
          if (response['status']) {
            showSnackbar(
              context,
              response['message'],
              SnackbarType.SUCCESS,
              navigate: true,
            );
            askAnExpertProvider.getDoubts();
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
                  Stack(
                    children:[ Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: PreMedColorTheme().white,
                        borderRadius: BorderRadius.circular(16),

                      ),
                      child: Consumer<UplaodImageProvider>(
                        builder: (context, value, child) {
                          final bool uploadedImage = value.uploadedImage != null;

                          return uploadedImage
                              ? Image.file(
                                  uplaodImageProvider.uploadedImage!,
                                  fit: BoxFit.fitHeight,
                                )
                              : const LocalImageDisplay();
                        },
                      ),
                // Implement LocalImageDisplay
                    ),
              ]
                  ),
                  SizedBoxes.verticalLarge,
                  const Padding(
                    padding:  EdgeInsets.only(left: 36,right: 36),
                    child: OrDivider(),
                  ),
                  SizedBoxes.verticalLarge,
                  CustomButton(
                    color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                    buttonText: 'Use Camera',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBoxes.verticalBig,
                  const CustomResourceDropDown(),
                  SizedBoxes.verticalBig,
                  const Text(
                    'What problems are you facing with the uploaded question?',
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBoxes.verticalTiny,
                  CustomTextField(
                    controller: descriptionController,
                    maxLines: 6,
                    hintText: 'Explain your issue briefly...',
                    validator: (value) =>
                        validateIsNotEmpty(value, "Description"),
                  ),
                  SizedBoxes.verticalBig,
                  CustomButton(
                    color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                    isActive:
                        askAnExpertProvider.doubtUploadStatus != Status.Sending,
                    buttonText:
                        askAnExpertProvider.doubtUploadStatus == Status.Sending
                            ? 'Submitting'
                            : 'Submit for 5 Coins',
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

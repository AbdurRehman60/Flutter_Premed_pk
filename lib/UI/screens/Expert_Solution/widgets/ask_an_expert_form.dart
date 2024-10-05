import 'package:premedpk_mobile_app/UI/screens/expert_solution/camera_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/local_image_display.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/dropdown_form.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/validators.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

    Future<void> _launchURL(String appToken) async {
      final url =
          'https://premed.pk/app-redirect?url=$appToken&&route="pricing/all"';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void onSubmitPressed() {
      final form = _formKey.currentState!;
      if (uplaodImageProvider.uploadedImage == null) {
        showError(context, {"message": "Please upload an Image"});
        return;
      }
      if (form.validate()) {
        final userPro = Provider.of<UserProvider>(context, listen: false);

        // Cast the featuresPurchased to List<Map<String, dynamic>>?
        final List<dynamic>? featuresPurchasedDynamic = userPro.user?.featuresPurchased;
        final List<Map<String, dynamic>>? featuresPurchased = featuresPurchasedDynamic?.cast<Map<String, dynamic>>();

        // Check if any plan's 'planName' contains 'ultimate'
        bool hasUltimatePlan = featuresPurchased?.any((feature) {
          final String? planName = feature['planName']; // Access the 'planName' field
          if (planName != null && planName.toLowerCase().contains('ultimate')) {
            return true; // Ultimate plan is found
          }
          return false; // Continue checking other plans
        }) ?? false;

        if (hasUltimatePlan) {
          print('Ultimate plan found: ${userPro.user?.featuresPurchased}');

          final Future<Map<String, dynamic>> response = askAnExpertProvider.uploadDoubt(
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
        } else {
          // Show pop-up to purchase plan
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final userProvider = Provider.of<UserProvider>(context);
              final String appToken = userProvider.user?.info.appToken?? '';
              return AlertDialog(
                title: const Text('Purchase Plan'),
                content: const Text('You need to purchase the Ultimate plan to upload doubts.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _launchURL(appToken);
                    },
                    child: const Text('Purchase'),
                  ),
                ],
              );
            },
          );
        }
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
                    isActive:
                    askAnExpertProvider.doubtUploadStatus != Status.Sending,
                    buttonText:
                    askAnExpertProvider.doubtUploadStatus == Status.Sending
                        ? 'Submitting'
                        : 'Submit',
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
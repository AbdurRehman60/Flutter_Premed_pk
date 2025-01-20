import 'package:flutter_svg/svg.dart';
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

    Future<void> launchURL(String appToken) async {
      // Use listen: false to avoid rebuilds in this context
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String lastonboarding = userProvider.user!.info.lastOnboardingPage;

      // Check if the lastonboarding URL contains "pre-medical" to decide the bundle path
      String bundlePath;
      if (lastonboarding.contains("pre-medical")) {
        bundlePath = "/bundles/mdcat";
      } else {
        bundlePath = "/bundles/all in one";
      }

      // Generate the final URL based on the condition
      final url = 'https://premed.pk/app-redirect?url=$appToken&&route=$bundlePath';

      // Try to launch the URL
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
        final bool hasUltimatePlan = featuresPurchased?.any((feature) {
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
                title: Column(
                  children: [
                    SvgPicture.asset('assets/icons/lock.svg'),
                    SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Oh No! It’s Locked',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Color(0xFFFE63C49),
                        ),
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Looks like this feature is not included in your plan. Upgrade to a higher plan or purchase this feature separately to continue.',
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Visit PreMed.PK for more details.',
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Return',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFFE63C49),
                          ),
                        ),
                      ),
                    ),
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
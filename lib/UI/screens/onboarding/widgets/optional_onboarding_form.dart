// import 'package:flutter/gestures.dart';
// import 'package:intl_phone_field/phone_number.dart';
// import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
// import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/check_box.dart';
// import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
// import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:premedpk_mobile_app/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
// import '../../account/widgets/privacy_policy.dart';
// import '../../account/widgets/terms_conditions.dart';
//
// class OptionalOnboardingForm extends StatefulWidget {
//   const OptionalOnboardingForm({super.key});
//
//   @override
//   State<OptionalOnboardingForm> createState() => _OptionalOnboardingFormState();
// }
//
// class _OptionalOnboardingFormState extends State<OptionalOnboardingForm> {
//   bool mdcatChecked = false;
//   bool privateChecked = false;
//   bool numsChecked = false;
//   TextEditingController parentNameController = TextEditingController();
//
//   String error = "";
//   bool hasErrors = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final AuthProvider auth = Provider.of<AuthProvider>(context);
//
//     void updateIntendFor() {
//       final List<String> intendFor = [];
//       if (mdcatChecked) {
//         intendFor.add('MDCAT');
//       }
//       if (privateChecked) {
//         intendFor.add('Private');
//       }
//       if (numsChecked) {
//         intendFor.add('NUMS');
//       }
//
//       auth.intendFor = intendFor;
//     }
//
//     void onPhoneNumberSelected(PhoneNumber phoneNumber) {
//       if (phoneNumber.number.isEmpty) {
//         auth.parentContactNumber = '';
//       } else {
//         auth.parentContactNumber = phoneNumber.completeNumber;
//       }
//     }
//
//     bool validateInput() {
//       error = '';
//       hasErrors = false;
//
//       if ((auth.parentFullName.isEmpty &&
//           auth.parentContactNumber.isNotEmpty) ||
//           (auth.parentFullName.isNotEmpty &&
//               auth.parentContactNumber.isEmpty)) {
//         setState(() {
//           error = "Parent's details can not be empty.";
//           hasErrors = true;
//         });
//       } else {
//         setState(() {
//           hasErrors = false;
//         });
//       }
//
//       return !hasErrors;
//     }
//
//     void onNextPressed() {
//       auth.parentFullName = parentNameController.text;
//       if (validateInput()) {
//         final Future<Map<String, dynamic>> response = auth.optionalOnboarding();
//
//         response.then(
//               (response) {
//             if (response['status']) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const RequiredOnboarding(),
//                 ),
//               );
//             } else {
//               showError(context, response);
//             }
//           },
//         );
//       }
//     }
//
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Parent's Information",
//                   style: PreMedTextTheme().subtext1,
//                 ),
//               ),
//               SizedBoxes.verticalTiny,
//               CustomTextField(
//                 controller: parentNameController,
//                 prefixIcon: const Icon(Icons.person_outline_rounded),
//                 labelText: "Parent/Guardian's Name",
//               ),
//               SizedBoxes.verticalTiny,
//               PhoneDropdown(
//                 onPhoneNumberSelected: onPhoneNumberSelected,
//                 hintText: "",
//                 initialValue: auth.phoneNumber,
//               ),
//               SizedBoxes.verticalBig,
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Your plans',
//                   style: PreMedTextTheme().subtext1,
//                 ),
//               ),
//               SizedBoxes.verticalLarge,
//               Text(
//                 'What do you intend to use PreMed.PK for ?',
//                 style: PreMedTextTheme().subtext,
//               ),
//               SizedBoxes.verticalLarge,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Flexible(
//                     child: CustomCheckBox(
//                       label: "MDCAT",
//                       initialValue: mdcatChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           mdcatChecked = value;
//                           updateIntendFor();
//                         });
//                       },
//                     ),
//                   ),
//                   Flexible(
//                     child: CustomCheckBox(
//                       label: "Private",
//                       initialValue: privateChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           privateChecked = value;
//                           updateIntendFor();
//                         });
//                       },
//                     ),
//                   ),
//                   Flexible(
//                     child: CustomCheckBox(
//                       label: "NUMS",
//                       initialValue: numsChecked,
//                       onChanged: (value) {
//                         setState(() {
//                           numsChecked = value;
//                           updateIntendFor();
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBoxes.verticalGargangua,
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Have you joined any academy?',
//                   style: PreMedTextTheme().subtext,
//                 ),
//               ),
//               SizedBoxes.verticalLarge,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: options.map((option) {
//                   return Row(
//                     children: [
//                       Radio(
//                         value: option,
//                         groupValue: auth.academyJoined,
//                         onChanged: (value) {
//                           auth.academyJoined = value!;
//                         },
//                         activeColor: PreMedColorTheme().tickcolor,
//                         visualDensity: VisualDensity.compact,
//                       ),
//                       Text(
//                         option,
//                         style: PreMedTextTheme().subtext,
//                       ),
//                       SizedBoxes.horizontalExtraGargangua,
//                       SizedBoxes.horizontalExtraGargangua,
//                     ],
//                   );
//                 }).toList(),
//               ),
//               SizedBoxes.verticalMedium,
//               if (hasErrors)
//                 Text(
//                   error,
//                   textAlign: TextAlign.center,
//                   style: PreMedTextTheme().subtext1.copyWith(
//                     color: Colors.redAccent,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//               else
//                 const SizedBox(),
//             ],
//           ),
//         ),
//         SizedBoxes.verticalTiny,
//         Column(
//           children: [
//             CustomButton(
//               buttonText: 'Next',
//               color: PreMedColorTheme().primaryColorRed,
//               textColor: PreMedColorTheme().white,
//               onPressed: onNextPressed,
//             ),
//             SizedBoxes.verticalTiny,
//             CustomButton(
//               buttonText: 'Skip',
//               color: PreMedColorTheme().white,
//               textColor: PreMedColorTheme().primaryColorRed,
//               onPressed: onNextPressed,
//             ),
//           ],
//         ),
//         SizedBoxes.verticalMicro,
//         RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(
//             style: PreMedTextTheme().body.copyWith(
//               color: PreMedColorTheme().neutral500,
//             ),
//             children: [
//               TextSpan(
//                 text: "By signing up, you agree to our ",
//                 style: PreMedTextTheme().body.copyWith(
//                   color: PreMedColorTheme().neutral500,
//                 ),
//               ),
//               TextSpan(
//                 text: "Privacy Policy",
//                 style: PreMedTextTheme().body.copyWith(
//                     color: PreMedColorTheme().neutral500,
//                     fontWeight: FontWeight.bold),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const PrivacyPolicy()));
//                   },
//               ),
//               TextSpan(
//                 text: " and ",
//                 style: PreMedTextTheme().body.copyWith(
//                   color: PreMedColorTheme().neutral500,
//                 ),
//               ),
//               TextSpan(
//                 text: "Terms of Use",
//                 style: PreMedTextTheme().body.copyWith(
//                     color: PreMedColorTheme().neutral500,
//                     fontWeight: FontWeight.bold),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const TermsCondition()));
//                   },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// List<String> options = [
//   'Yes',
//   'No',
// ];

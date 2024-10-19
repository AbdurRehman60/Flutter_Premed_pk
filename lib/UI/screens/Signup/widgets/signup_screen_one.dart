// import 'package:flutter/gestures.dart';
// import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
// import 'package:premedpk_mobile_app/UI/screens/Login/animation.dart';
// import 'package:premedpk_mobile_app/UI/screens/Login/login_screen_one.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
//
// import '../../account/widgets/privacy_policy.dart';
// import '../../account/widgets/terms_conditions.dart';
// import '../Signup.dart';
//
// class SignUp extends StatefulWidget {
//   final String lastOnboardingPage;
//
//   const SignUp({required this.lastOnboardingPage, super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   @override
//   Widget build(BuildContext context) {
//     final buttonSize = MediaQuery.of(context).size.width * 0.7;
//     return Scaffold(
//       backgroundColor: PreMedColorTheme().neutral60,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                         height: 240,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           color: PreMedColorTheme().white,
//                         ),
//                         child: const MovingRowAnimation()),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20.0, vertical: 20.0),
//                       child: Column(
//                         children: [
//                           SizedBoxes.verticalBig,
//                           Column(
//                             children: [
//                               SizedBoxes.verticalBig,
//                               Text(
//                                 'Sign Up',
//                                 textAlign: TextAlign.center,
//                                 style: PreMedTextTheme().heading1.copyWith(
//                                     color: PreMedColorTheme().primaryColorRed,
//                                     fontWeight: FontWeight.w800,
//                                     fontSize: 34),
//                               ),
//                               SizedBoxes.verticalTiny,
//                               RichText(
//                                 textAlign: TextAlign.center,
//                                 text: TextSpan(
//                                   style: PreMedTextTheme().subtext.copyWith(
//                                     color: PreMedColorTheme().black,
//                                     fontSize: 14,
//                                   ),
//                                   children: [
//                                     TextSpan(
//                                       text: 'A warm welcome to the ',
//                                       style: PreMedTextTheme()
//                                           .subtext1
//                                           .copyWith(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14),
//                                     ),
//                                     TextSpan(
//                                       text: 'Pre',
//                                       style: PreMedTextTheme()
//                                           .subtext1
//                                           .copyWith(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 14),
//                                     ),
//                                     TextSpan(
//                                       text: 'M',
//                                       style: PreMedTextTheme()
//                                           .subtext1
//                                           .copyWith(
//                                           color: PreMedColorTheme()
//                                               .primaryColorRed,
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 14),
//                                     ),
//                                     TextSpan(
//                                       text: 'ed ',
//                                       style: PreMedTextTheme()
//                                           .subtext1
//                                           .copyWith(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 14),
//                                     ),
//                                     TextSpan(
//                                       text:
//                                       "family! We're delighted to have you here. Let the magic begin!",
//                                       style: PreMedTextTheme()
//                                           .subtext1
//                                           .copyWith(
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBoxes.verticalExtraGargangua,
//                           const GoogleLogin(),
//                           SizedBoxes.verticalBig,
//                           const Padding(
//                             padding: EdgeInsets.only(left: 64, right: 64),
//                             child: OrDivider(),
//                           ),
//                           SizedBoxes.verticalBig,
//                           Center(
//                             child: SizedBox(
//                               width: buttonSize,
//                               height: 50,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SignUpScreen(
//                                         lastOnboardingPage: widget.lastOnboardingPage,
//                                       ),
//                                     ),
//                                   );
//                                   final url = widget.lastOnboardingPage;
//                                   print("this is the lastonboarding url $url");
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: PreMedColorTheme().white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   elevation: 3,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.mail_outline,
//                                               color: PreMedColorTheme().black,
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 'Sign up with Email',
//                                                 textAlign: TextAlign.center,
//                                                 style:
//                                                 PreMedTextTheme().subtext,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBoxes.verticalTiny,
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Already have an account?",
//                                 style: PreMedTextTheme().subtext.copyWith(
//                                     fontWeight: FontWeight.w400, fontSize: 14),
//                               ),
//                               TextButton(
//                                 child: Text(
//                                   'Sign In',
//                                   style: PreMedTextTheme().subtext1.copyWith(
//                                       color: PreMedColorTheme().primaryColorRed,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 14),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => const SignIn(),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     style: PreMedTextTheme().body.copyWith(
//                       color: PreMedColorTheme().neutral500,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: "By signing in, you agree to our ",
//                         style: PreMedTextTheme().body.copyWith(
//                             color: PreMedColorTheme().neutral500,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 11),
//                       ),
//                       TextSpan(
//                         text: "Privacy Policy",
//                         style: PreMedTextTheme().body1.copyWith(
//                             color: PreMedColorTheme().neutral500,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 11),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                     const PrivacyPolicy()));
//                           },
//                       ),
//                       TextSpan(
//                         text: " and ",
//                         style: PreMedTextTheme().body.copyWith(
//                             color: PreMedColorTheme().neutral500,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 11),
//                       ),
//                       TextSpan(
//                         text: "Terms of Use",
//                         style: PreMedTextTheme().body1.copyWith(
//                             color: PreMedColorTheme().neutral500,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 11),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                     const TermsCondition()));
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

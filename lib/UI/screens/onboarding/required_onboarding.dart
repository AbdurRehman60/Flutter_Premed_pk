// import 'package:premedpk_mobile_app/UI/screens/onboarding/optional_onboarding.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:provider/provider.dart';
// import '../../../providers/auth_provider.dart';
// import '../../../providers/user_provider.dart';
// import '../../Widgets/global_widgets/error_dialogue.dart';
//
// class RequiredOnboarding extends StatefulWidget {
//   const RequiredOnboarding({super.key});
//
//   @override
//   State<RequiredOnboarding> createState() => _RequiredOnboardingState();
// }
//
// class _RequiredOnboardingState extends State<RequiredOnboarding> {
//   late List<bool> isTappedList;
//   List<String> selectedExams = [];
//   List<String> selectedFeatures = [];
//
//   @override
//   void initState() {
//     super.initState();
//     isTappedList = List.filled(18, false);
//   }
//
//   void _onContainerTap(int index, String examText) {
//     setState(() {
//       isTappedList[index] = !isTappedList[index];
//       if (isTappedList[index]) {
//         selectedExams.add(examText);
//       } else {
//         selectedExams.remove(examText);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final username = UserProvider().user?.fullName;
//     final UserProvider userProvider = Provider.of<UserProvider>(context);
//     final String? lastob = userProvider.user?.info.lastOnboardingPage;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double containerWidth = screenWidth * 0.35;
//
//     return Scaffold(
//       backgroundColor: PreMedColorTheme().neutral60,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBoxes.verticalGargangua,
//                             RichText(
//                               text: TextSpan(
//                                   style: PreMedTextTheme().subtext.copyWith(
//                                       color: PreMedColorTheme().black,
//                                       fontSize: 35,
//                                       fontWeight: FontWeight.w700),
//                                   children: [
//                                     const TextSpan(
//                                       text: 'Hi, ',
//                                     ),
//                                     WidgetSpan(
//                                       child: GradientText(
//                                         text: username ?? '',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 35,
//                                         ),
//                                         gradient: LinearGradient(
//                                           colors: <Color>[
//                                             Colors.purple,
//                                             PreMedColorTheme().primaryColorRed,
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: '!',
//                                       style: PreMedTextTheme()
//                                           .subtext1
//                                           .copyWith(
//                                               color: PreMedColorTheme().black,
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 35),
//                                     ),
//                                   ]),
//                             ),
//                             SizedBoxes.verticalLarge,
//                             RichText(
//                               text: TextSpan(
//                                   style: PreMedTextTheme().subtext.copyWith(
//                                       color: PreMedColorTheme().black,
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.w700),
//                                   children: [
//                                     const TextSpan(
//                                       text: 'What ',
//                                     ),
//                                     TextSpan(
//                                         text: 'exam ',
//                                         style: PreMedTextTheme()
//                                             .heading3
//                                             .copyWith(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 25,
//                                                 color: PreMedColorTheme()
//                                                     .primaryColorRed)),
//                                     TextSpan(
//                                       text: 'are you preparing for?',
//                                       style:
//                                           PreMedTextTheme().subtext1.copyWith(
//                                                 color: PreMedColorTheme().black,
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 25,
//                                               ),
//                                     ),
//                                   ]),
//                             ),
//                             SizedBoxes.verticalMicro,
//                             Text(
//                               'You can select more than one',
//                               style: PreMedTextTheme().body.copyWith(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                             ),
//                             SizedBoxes.verticalLarge,
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => _onContainerTap(
//                                       0,
//                                       lastob ==
//                                               'auth/onboarding/entrance-exam/pre-medical'
//                                           ? 'MDCAT'
//                                           : 'FAST'),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[0]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 6,
//                                       ),
//                                     ),
//                                     width: containerWidth,
//                                     height: 90,
//                                     child: Center(
//                                         child: Text(
//                                       textAlign: TextAlign.center,
//                                       lastob ==
//                                               'auth/onboarding/entrance-exam/pre-medical'
//                                           ? 'MDCAT'
//                                           : 'FAST',
//                                       style: PreMedTextTheme()
//                                           .heading3
//                                           .copyWith(
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 20,
//                                               color: PreMedColorTheme()
//                                                   .primaryColorRed),
//                                     )),
//                                   ),
//                                 ),
//                                 SizedBoxes.horizontal24Px,
//                                 GestureDetector(
//                                   onTap: () => _onContainerTap(
//                                       1,
//                                       lastob ==
//                                               'auth/onboarding/entrance-exam/pre-medical'
//                                           ? 'NUMS'
//                                           : 'NUST'),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[1]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 6,
//                                       ),
//                                     ),
//                                     width: containerWidth,
//                                     height: 90,
//                                     child: Center(
//                                         child: Text(
//                                       textAlign: TextAlign.center,
//                                       lastob ==
//                                               'auth/onboarding/entrance-exam/pre-medical'
//                                           ? 'NUMS'
//                                           : 'NUST',
//                                       style: PreMedTextTheme()
//                                           .heading3
//                                           .copyWith(
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 20,
//                                               color: PreMedColorTheme()
//                                                   .primaryColorRed),
//                                     )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBoxes.verticalMedium,
//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => _onContainerTap(
//                                       2,
//                                       lastob ==
//                                               'auth/onboarding/entrance-exam/pre-medical'
//                                           ? 'Private Universities'
//                                           : 'GIKI'),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[2]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 6,
//                                       ),
//                                     ),
//                                     width: containerWidth,
//                                     height: 90,
//                                     child: Center(
//                                         child: Text(
//                                       textAlign: TextAlign.center,
//                                       lastob ==
//                                               'auth/onboarding/entrance-exam/pre-medical'
//                                           ? 'Private Universities'
//                                           : 'GIKI',
//                                       style: PreMedTextTheme()
//                                           .heading3
//                                           .copyWith(
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 20,
//                                               color: PreMedColorTheme()
//                                                   .primaryColorRed),
//                                     )),
//                                   ),
//                                 ),
//                                 SizedBoxes.horizontal24Px,
//                                 if (lastob ==
//                                     'auth/onboarding/entrance-exam/pre-engineering')
//                                   GestureDetector(
//                                     onTap: () => _onContainerTap(3, 'UET'),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: const Color(0x80FFFFFF),
//                                         border: Border.all(
//                                           width: 6,
//                                           color: isTappedList[3]
//                                               ? PreMedColorTheme()
//                                                   .primaryColorRed
//                                               : Colors.white,
//                                         ),
//                                       ),
//                                       width: containerWidth,
//                                       height: 90,
//                                       child: Center(
//                                           child: Text(
//                                         textAlign: TextAlign.center,
//                                         'UET',
//                                         style:
//                                             PreMedTextTheme().heading3.copyWith(
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: 20,
//                                                   color: PreMedColorTheme()
//                                                       .primaryColorRed,
//                                                 ),
//                                       )),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             SizedBoxes.verticalMedium,
//                             if (lastob ==
//                                 'auth/onboarding/entrance-exam/pre-engineering')
//                               GestureDetector(
//                                 onTap: () => _onContainerTap(4, 'NED'),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: const Color(0x80FFFFFF),
//                                     border: Border.all(
//                                       width: 6,
//                                       color: isTappedList[4]
//                                           ? PreMedColorTheme().primaryColorRed
//                                           : Colors.white,
//                                     ),
//                                   ),
//                                   width: containerWidth,
//                                   height: 90,
//                                   child: Center(
//                                       child: Text(
//                                     textAlign: TextAlign.center,
//                                     'NED',
//                                     style: PreMedTextTheme().heading3.copyWith(
//                                           fontWeight: FontWeight.w800,
//                                           fontSize: 20,
//                                           color: PreMedColorTheme()
//                                               .primaryColorRed,
//                                         ),
//                                   )),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         SizedBoxes.verticalLarge,
//                         RichText(
//                           text: TextSpan(
//                               style: PreMedTextTheme().subtext.copyWith(
//                                   color: PreMedColorTheme().black,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.w700),
//                               children: [
//                                 const TextSpan(
//                                   text: 'What ',
//                                 ),
//                                 TextSpan(
//                                     text: 'features ',
//                                     style: PreMedTextTheme().heading3.copyWith(
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 25,
//                                         color:
//                                             PreMedColorTheme().highschoolblue)),
//                                 TextSpan(
//                                   text: 'do you want?',
//                                   style: PreMedTextTheme().subtext1.copyWith(
//                                         color: PreMedColorTheme().black,
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 25,
//                                       ),
//                                 ),
//                               ]),
//                         ),
//                         SizedBoxes.verticalMicro,
//                         Text(
//                           'You can select more than one',
//                           style: PreMedTextTheme().body.copyWith(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                         ),
//                         SizedBoxes.verticalLarge,
//                         Row(
//                           //  mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[5] = !isTappedList[5];
//                                     if (isTappedList[5]) {
//                                       selectedFeatures.add('Topicals');
//                                     } else {
//                                       selectedFeatures.remove('Topicals');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[5]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Topicals',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                             SizedBoxes.horizontal15Px,
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[6] = !isTappedList[6];
//                                     if (isTappedList[6]) {
//                                       selectedFeatures.add('Flashcards');
//                                     } else {
//                                       selectedFeatures.remove('Flashcards');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         width: 5,
//                                         color: isTappedList[6]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                       )),
//                                   height: 80,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Flashcards',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBoxes.verticalTiny,
//                         Row(
//                           //  mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[7] = !isTappedList[7];
//                                     if (isTappedList[7]) {
//                                       selectedFeatures.add('Revision Notes');
//                                     } else {
//                                       selectedFeatures.remove('Revision Notes');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[7]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Revision Notes',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                             SizedBoxes.horizontal15Px,
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[8] = !isTappedList[8];
//                                     if (isTappedList[8]) {
//                                       selectedFeatures.add('Statistics');
//                                     } else {
//                                       selectedFeatures.remove('Statistics');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[8]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Statistics',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBoxes.verticalTiny,
//                         Row(
//                           //  mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[9] = !isTappedList[9];
//                                     if (isTappedList[9]) {
//                                       selectedFeatures.add('Mocks');
//                                     } else {
//                                       selectedFeatures.remove('Mocks');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[9]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Mocks',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                             SizedBoxes.horizontal15Px,
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[10] = !isTappedList[10];
//                                     if (isTappedList[10]) {
//                                       selectedFeatures.add('Mnemonics');
//                                     } else {
//                                       selectedFeatures.remove('Mnemonics');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[10]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Mnemonics',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBoxes.verticalTiny,
//                         Row(
//                           //  mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[11] = !isTappedList[11];
//                                     if (isTappedList[11]) {
//                                       selectedFeatures.add('Guides');
//                                     } else {
//                                       selectedFeatures.remove('Guides');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         width: 5,
//                                         color: isTappedList[11]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Guides',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                             SizedBoxes.horizontal15Px,
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[12] = !isTappedList[12];
//                                     if (isTappedList[12]) {
//                                       selectedFeatures.add('Recent Activity');
//                                     } else {
//                                       selectedFeatures
//                                           .remove('Recent Activity');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[12]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Recent Activity',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBoxes.verticalTiny,
//                         Row(
//                           //  mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[13] = !isTappedList[13];
//                                     if (isTappedList[13]) {
//                                       selectedFeatures.add("Expert's Solution");
//                                     } else {
//                                       selectedFeatures
//                                           .remove("Expert's Solution");
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[13]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Center(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           "Expert's Solution",
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                                 ),
//                               ),
//                             ),
//                             SizedBoxes.horizontal15Px,
//                             IntrinsicWidth(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isTappedList[14] = !isTappedList[14];
//                                     if (isTappedList[14]) {
//                                       selectedFeatures.add('Yearly');
//                                     } else {
//                                       selectedFeatures.remove('Yearly');
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: const Color(0x80FFFFFF),
//                                       border: Border.all(
//                                         color: isTappedList[14]
//                                             ? PreMedColorTheme().primaryColorRed
//                                             : Colors.white,
//                                         width: 5,
//                                       )),
//                                   //width: containerWidth,
//                                   height: 80,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       children: [
//                                         Image.asset(
//                                           PremedAssets.Books,
//                                           width: 24,
//                                           height: 24,
//                                         ),
//                                         SizedBoxes.horizontal10Px,
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           'Yearly',
//                                           style: PreMedTextTheme()
//                                               .heading3
//                                               .copyWith(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 15,
//                                                   color:
//                                                       PreMedColorTheme().black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBoxes.verticalTiny,
//                         IntrinsicWidth(
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 isTappedList[15] = !isTappedList[15];
//                                 if (isTappedList[15]) {
//                                   selectedFeatures.add('Recorded Lectures');
//                                 } else {
//                                   selectedFeatures.remove('Recorded Lectures');
//                                 }
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: const Color(0x80FFFFFF),
//                                   border: Border.all(
//                                     width: 5,
//                                     color: isTappedList[15]
//                                         ? PreMedColorTheme().primaryColorRed
//                                         : Colors.white,
//                                   )),
//                               //width: containerWidth,
//                               height: 80,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     Image.asset(
//                                       PremedAssets.Books,
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                     SizedBoxes.horizontal10Px,
//                                     Text(
//                                       textAlign: TextAlign.center,
//                                       'Recorded Lectures',
//                                       style: PreMedTextTheme()
//                                           .heading3
//                                           .copyWith(
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 15,
//                                               color: PreMedColorTheme().black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 16,
//               right: 16,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     icon: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: PreMedColorTheme().primaryColorRed200,
//                           width: 6,
//                         ),
//                       ),
//                       child: CircleAvatar(
//                         backgroundColor: PreMedColorTheme().neutral60,
//                         radius: 20,
//                         child: Icon(
//                           Icons.arrow_back_rounded,
//                           size: 28,
//                           color: PreMedColorTheme().primaryColorRed,
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       _submitSelectedExamsAndFeatures(username, lastob);
//                       print(
//                           "this is the username in required onboarding $username");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const OptionalOnboarding()),
//                       );
//                     },
//                     icon: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: PreMedColorTheme().bordercolor,
//                           width: 6,
//                         ),
//                       ),
//                       child: CircleAvatar(
//                         backgroundColor: PreMedColorTheme().primaryColorRed,
//                         radius: 28,
//                         child: const Icon(
//                           Icons.arrow_forward_rounded,
//                           size: 34,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _submitSelectedExamsAndFeatures(String? username, String? lastob) {
//     if (username != null && lastob != null) {
//       final AuthProvider auth =
//           Provider.of<AuthProvider>(context, listen: false);
//       auth
//           .requiredOnboarding(
//         isAvailableOnWhatsApp: false,
//
//         username: UserProvider().user!.userName,
//         lastOnboardingPage: '$lastob/features',
//         selectedExams: selectedExams,
//         selectedFeatures: selectedFeatures,
//         city: '',
//         educationSystem: '',
//         year: '',
//         parentContactNumber: '',
//         approach: '',
//         phoneNumber: '',
//         institution: '',
//       )
//           .then((response) {
//         if (response['status']) {
//         } else {
//           showError(context, response);
//         }
//       });
//     }
//   }
// }
//
// class GradientText extends StatelessWidget {
//   const GradientText({
//     super.key,
//     required this.text,
//     required this.style,
//     required this.gradient,
//   });
//
//   final String text;
//   final TextStyle style;
//   final Gradient gradient;
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (bounds) {
//         return gradient
//             .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
//       },
//       child: Text(
//         text,
//         style: style.copyWith(color: Colors.white),
//       ),
//     );
//   }
//
//   // Future<void> submitOnboardingData() async {
//   //
//   //   try {
//   //     final result = await auth.requiredOnboarding(
//   //       username: username!,
//   //       lastOnboardingPage: '$lastob/additional-info',
//   //       selectedExams: exams,
//   //       selectedFeatures: features,
//   //       city: city,
//   //       educationSystem: educationSystem,
//   //       year: year,
//   //       parentContactNumber: parentContactNumber,
//   //       approach: knownVia,
//   //       phoneNumber: phoneNumber,
//   //       institution: institution,
//   //     );
//   //
//   //     if (result['status']) {
//   //       Navigator.pushAndRemoveUntil(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => const MainNavigationScreen(),
//   //         ),
//   //             (route) => false,
//   //       );
//   //     } else {
//   //       setState(() {
//   //         error = 'Failed to submit data. Please try again.';
//   //         hasErrors = true;
//   //       });
//   //       showErrorDialog(error);
//   //     }
//   //   } catch (e) {
//   //     setState(() {
//   //       error = 'An error occurred. Please try again.';
//   //       hasErrors = true;
//   //     });
//   //     showErrorDialog(error);
//   //   }
//   // }
// }

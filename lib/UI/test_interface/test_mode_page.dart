// import 'package:google_fonts/google_fonts.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
//
// import '../screens/global_qbank/widgets/mode_container.dart';
//
//
// class TestModeInterface extends StatefulWidget {
//   const TestModeInterface({super.key});
//
//   @override
//   State<TestModeInterface> createState() => _TestModeInterfaceState();
// }
//
// class _TestModeInterfaceState extends State<TestModeInterface> {
//   bool tutorModeButton = true;
//   bool timeTestModeButton = false;
//   String mode = 'tutorMode';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Material(
//             elevation: 4,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             clipBehavior: Clip.hardEdge,
//             child: const SizedBox(
//               height: 37,
//               width: 37,
//               child: Icon(
//                 Icons.arrow_back_outlined,
//                 color: Color(0xFFEC5863),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Center(
//                   child: SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: Image.asset(
//                       'assets/images/uni-logo.jpg',
//                     ),
//                   ),
//                 ),
//                 SizedBoxes.verticalBig,
//                 Text(
//                   'Federal\nMDCAT 2023',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.rubik(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 24,
//                     color: const Color(0xFF000000),
//                   ),
//                 ),
//                 SizedBoxes.verticalMicro,
//                 Text(
//                   '200 Questions',
//                   style: GoogleFonts.rubik(
//                     fontWeight: FontWeight.w200,
//                     fontSize: 24,
//                     color: const Color(0xFF000000),
//                   ),
//                 ),
//                 SizedBoxes.vertical10Px,
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 12),
//                   padding: const EdgeInsets.symmetric(horizontal: 6),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF000000),
//                     borderRadius: BorderRadius.circular(55),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ModeContainer(
//                         onTap: () {
//                           setState(() {
//                             tutorModeButton = true;
//                             timeTestModeButton = false;
//                             mode = 'tutorMode';
//                           });
//                         },
//                         modeTitle: 'Tutor Mode',
//                         colors: const [Color(0xFF9EB6EF), Color(0xFFE75E6B)],
//                         buttonColor: tutorModeButton
//                             ? const Color(0xFF454B53)
//                             : Colors.transparent,
//                       ),
//                       ModeContainer(
//                         onTap: () {
//                           setState(() {
//                             timeTestModeButton = true;
//                             tutorModeButton = false;
//                             mode = 'testTimeMode';
//                           });
//                         },
//                         modeTitle: 'Timed Mode Test',
//                         colors: const [Color(0xFF6EA3E6), Color(0xFF47D48F)],
//                         buttonColor: timeTestModeButton
//                             ? const Color(0xFF454B53)
//                             : Colors.transparent,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBoxes.verticalBig,
//                 ModeDescription(
//                   mode: mode,
//                 ),
//                 SizedBoxes.verticalBig,
//                 Material(
//                   borderRadius: BorderRadius.circular(24),
//                   clipBehavior: Clip.hardEdge,
//                   elevation: 4,
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(
//                             width: 1.5, color: const Color(0xFF928F8F))),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Instructions',
//                           style: GoogleFonts.rubik(
//                             color: const Color(0xFF2477BB),
//                             fontWeight: FontWeight.w800,
//                             fontSize: 18,
//                           ),
//                         ),
//                         SizedBoxes.verticalTiny,
//                         Text(
//                           'This paper consists of total 200 Questions 18 English 68 Biology 54 Chemistry 54 Physics 6 Logical Reasoning The time allotted for this paper was 210 minutes, however, since you are attempting this in tutor mode, there is no timer and you are free to leave at any point and resume or start over. Each question has only one correct answer. You can move between questions using left/right arrow keys too. You can save a question, and come back to it at any time. Some questions of this paper have been modified, as they were cancelled that year.',
//                           style: GoogleFonts.rubik(
//                               color: const Color(0xFF5A6169), fontSize: 14),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

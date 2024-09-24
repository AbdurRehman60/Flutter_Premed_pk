// import 'package:flutter/material.dart';
// import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
// import 'package:premedpk_mobile_app/constants/color_theme.dart';
// import 'package:provider/provider.dart';
// import '../../../../models/deck_group_model.dart';
// import '../../../../models/paper_model.dart';
// import '../../../../providers/paper_provider.dart';
// import '../../../../providers/user_provider.dart';
// import '../../Test Interface/widgets/tutor_mode_test_interface.dart';
// import 'logo_avatar.dart';
//
// class PracticeAndPast extends StatefulWidget {
//   const PracticeAndPast({
//     super.key,
//     required this.deckDetails,
//     required this.deckGroupName,
//     required this.subject,
//     required this.premiumtag,
//     required this.totalquestions,
//     this.questionlist,
//   });
//
//   final List<String>? questionlist;
//
//   final int totalquestions;
//   final Map<String, dynamic> deckDetails;
//   final String deckGroupName;
//   final String subject;
//   final String premiumtag;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _PracticeAndPastState();
//   }
// }
//
// class _PracticeAndPastState extends State<PracticeAndPast> {
//   final List<bool> _isSelected = [true, false];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPapers();
//   }
//
//   // void _fetchPapers() {
//   //   final paperProvider = Provider.of<PaperProvider>(context, listen: false);
//   //   final userProvider = Provider.of<UserProvider>(context,listen: false);
//   //   final userId =  userProvider.user!.userId;
//   //   paperProvider.fetchPapers(widget.name,widget.category,widget.deckGroup.deckGroupName, userId);
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: const PopButton(),
//       ),
//       body: Consumer<PaperProvider>(
//         builder: (context, provider, child) {
//           if (provider.fetchStatus == PaperFetchStatus.loading) {
//
//             return const Center(child: CircularProgressIndicator());
//           } else if (provider.fetchStatus == PaperFetchStatus.error) {
//
//             return const Center(child: Text('Failed to load papers.'));
//           } else if (provider.fetchStatus == PaperFetchStatus.success) {
//
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         GetLogo(url: widget.logo),
//                         const SizedBox(height: 8),
//                         Text(
//                           widget.name,
//                           style: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 4),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: ToggleButtons(
//                       isSelected: _isSelected,
//                       borderRadius: BorderRadius.circular(20),
//                       fillColor: PreMedColorTheme().red,
//                       selectedColor: Colors.white,
//                       color: Colors.black,
//                       children: const [
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Text('Past Paper\nMDCAT-Topicals'),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Text('Practice\nMDCAT-Topicals'),
//                         ),
//                       ],
//                       onPressed: (index) {
//                         setState(() {
//                           for (int buttonIndex = 0;
//                           buttonIndex < _isSelected.length;
//                           buttonIndex++) {
//                             _isSelected[buttonIndex] =
//                                 buttonIndex == index;
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                   if (_isSelected[0])
//                     _buildPastPaperContent(provider.pastPaper)
//                   else
//                     _buildPracticeContent(provider.practicePaper),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('No data available.'));
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildPastPaperContent(Paper? pastPaper) {
//     if (pastPaper == null) {
//       return const Center(child: Text('No Past Paper available.'));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Past Paper Questions',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Column(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.double_arrow_outlined,
//                               color: PreMedColorTheme().red,
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'This toggle allows you to solve all the\npractice questions from well-known\nacademies.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.double_arrow_outlined,
//                               color: PreMedColorTheme().red,
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'Experts at PreMed.PK recommend\nstudents to use this toggle for deeper\nunderstanding of the topic.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.double_arrow_outlined,
//                               color: PreMedColorTheme().red,
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'It is recommended for students to use\nthis toggle after finishing a topic for\nextra practice.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TutorMode(
//                       deckName: pastPaper.deckName,
//                       attemptId: pastPaper.id,
//                       subject: widget.category,
//                       isContinuingAttempt: false,
//                       totalquestions: 300,
//
//                     ),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: PreMedColorTheme().red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(9),
//                 ),
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//               ),
//               child: const Text(
//                 'Start Attempting Questions',
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _buildPracticeContent(Paper? practicePaper) {
//     if (practicePaper == null) {
//       return const Center(child: Text('No Practice Paper available.'));
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Flexible(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       children: [
//                         Text(
//                           'Practice Questions',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Column(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.double_arrow_outlined,
//                               color: PreMedColorTheme().red,
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'This toggle allows you to solve all the\npractice questions from well-known\nacademies.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.double_arrow_outlined,
//                               color: PreMedColorTheme().red,
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'Experts at PreMed.PK recommend\nstudents to use this toggle for deeper\nunderstanding of the topic.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.double_arrow_outlined,
//                               color: PreMedColorTheme().red,
//                             ),
//                             const SizedBox(width: 17),
//                             const Text(
//                               'It is recommended for students to use\nthis toggle after finishing a topic for\nextra practice.',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 print('deckName : ${practicePaper.deckName}');
//                 print('attemptId : ${practicePaper.id}');
//                 print('subject : ${widget.category}');
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TutorMode(
//                       deckName: practicePaper.deckName,
//                       attemptId: practicePaper.id,
//                       subject: widget.category,
//                       isContinuingAttempt: false,
//                       totalquestions: 300,
//                     ),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: PreMedColorTheme().red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(9),
//                 ),
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//               ),
//               child: const Text(
//                 'Start Practicing Questions',
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/customised_buttons/qbank_button_y.dart';
// import 'package:premedpk_mobile_app/UI/screens/qbanks/widgets/build_error.dart';
// import 'package:premedpk_mobile_app/UI/screens/qbanks/widgets/qbank_tile.dart';
// import 'package:premedpk_mobile_app/UI/screens/qbanks/widgets/sub_bank_tile.dart';
// import 'package:premedpk_mobile_app/UI/screens/qbanks/widgets/test_mode_page.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:premedpk_mobile_app/models/deck_model.dart';
// import 'package:premedpk_mobile_app/providers/decks_provider.dart';
// import 'package:premedpk_mobile_app/providers/questions_proivder.dart';
// import 'package:provider/provider.dart';
//
// import '../mdcat_qb/mdcat_yearly_papers/federal_mdcat_papers.dart';
//
// class TestBank extends StatelessWidget {
//   const TestBank({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final deckPro = Provider.of<QuestionsProvider>(context, listen: false);
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
//             child: SizedBox(
//               width: 37,
//               height: 37,
//               child: Image.asset('assets/icons/Vector.png'),
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
//           child: Column(
//             children: [
//               Text(
//                 'Attempt a Full-Length Yearly Paper today and experience the feeling of giving the exam on the actual test day!',
//                 textAlign: TextAlign.center,
//                 style: PreMedTextTheme().heading2.copyWith(fontSize: 12),
//               ),
//               SizedBoxes.vertical26,
//               Expanded(
//                 child: FutureBuilder<Map<String, dynamic>>(
//                   future: Provider.of<QuestionsProvider>(context, listen: false)
//                       .fetchQuestions(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return _buildLoading(); // Show loading indicator
//                     } else if (snapshot.hasError) {
//                       return buildError(); // Show error message
//                     } else {
//                       final Map<String, dynamic>? data = snapshot.data;
//                       if (data != null && data['status'] == true) {
//                         final pro = Provider.of<QuestionsProvider>(context,
//                             listen: false);
//                         final lis = pro.qids;
//                         // Data loaded successfully
//                         return Text(lis[1].id);
//                       } else {
//                         // Data loading failed
//                         return buildError(message: data?['message']);
//                       }
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoading() {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//
//   void pop(context) {
//     Navigator.pop(context);
//   }
// }

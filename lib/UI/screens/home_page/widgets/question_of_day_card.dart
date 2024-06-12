// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class QuestionCard extends st {
//   final String question;
//   final List<String>? options;
//   final String? correctAnswer;

//   const QuestionCard({
//     Key? key,
//     required this.question,
//     this.options,
//     this.correctAnswer,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String _selectedOption = '';
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'QUESTION OF THE DAY',
//               style: GoogleFonts.rubik(
//                   fontWeight: FontWeight.w800,
//                   fontSize: 12,
//                   color: const Color(0xFF000000)),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               question,
//               style: GoogleFonts.rubik(
//                   fontWeight: FontWeight.w600, fontSize: 15, color: Colors.red),
//             ),
//             const SizedBox(height: 24),
//          Wrap(
//   spacing: 8,
//   runSpacing: 8,
//   children: options!
//       .map((option) => ChoiceChip(
//             label: Text(option),
//             selectedColor: Colors.blue,
//             selected: option == _selectedOption,
//             onSelected: (selected) {
//               if (selected) {
//                 (() {
//                   _selectedOption = option;
//                 });
//               }
//             },
//           ))
//       .toList(),
// )
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:premedpk_mobile_app/constants/color_theme.dart';
// import 'package:premedpk_mobile_app/constants/text_theme.dart';

// class QuestionCard extends StatefulWidget {
//   final String question;
//   final String tagName;
//   final bool isResource;

//   const QuestionCard({
//     Key? key,
//     required this.question,
//    required this.tagName, required this.isResource,
//   }) : super(key: key);

//   @override
//   _QuestionCardState createState() => _QuestionCardState();
// }

// class _QuestionCardState extends State<QuestionCard> {

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'QUESTION OF THE DAY',
//               style: GoogleFonts.rubik(
//                   fontWeight: FontWeight.w800,
//                   fontSize: 12,
//                   color: const Color(0xFF000000)),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               widget.question,
//               style: GoogleFonts.rubik(
//                   fontWeight: FontWeight.w600, fontSize: 15, color: Colors.red),
//             ),
//             const SizedBox(height: 24),
//             Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color:
//                   ? PreMedColorTheme().primaryColorRed100
//                   : PreMedColorTheme().primaryColorBlue100,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(tagName,
//                 style: PreMedTextTheme().small.copyWith(
//                       color: isResource
//                           ? PreMedColorTheme().primaryColorRed800
//                           : PreMedColorTheme().primaryColorBlue800,
//                     )),
//           )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final List<String> tags;
  final bool isResource;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.tags,
    required this.isResource,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUESTION OF THE DAY',
              style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: const Color(0xFF000000)),
            ),
            const SizedBox(height: 16),
            Text(
              widget.question,
              style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600, fontSize: 15, color: Colors.red),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              children: widget.tags.map((tag) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        widget.isResource ? Colors.red[100] : Colors.blue[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(tag,
                      style: PreMedTextTheme().small.copyWith(
                            color: widget.isResource
                                ? Colors.red[800]
                                : Colors.blue[800],
                          )),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.tags,
    required this.isResource,
  });
  final String question;
  final List<String> tags;
  final bool isResource;

  @override
  // ignore: library_private_types_in_public_api
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.04), // 4% of screen width
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              MediaQuery.of(context).size.width * 0.03, // 3% of screen width
          vertical:
              MediaQuery.of(context).size.height * 0.03, // 2% of screen height
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QUESTION OF THE DAY',
              style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w800,
                  fontSize: MediaQuery.of(context).size.width *
                      0.028, // 2.8% of screen width
                  color: const Color.fromARGB(255, 74, 74, 74)),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.01), // 2% of screen height
            Text(
              widget.question,
              style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width *
                      0.035, // 3.5% of screen width
                  color: Colors.red),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.01), // 4% of screen height
            Wrap(
              spacing: MediaQuery.of(context).size.width *
                  0.02, // 2% of screen width
              children: widget.tags.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width *
                        0.02, // 2% of screen width
                    vertical: MediaQuery.of(context).size.height *
                        0.01, // 1% of screen height
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.isResource ? Colors.red[100] : Colors.blue[100],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/widgets/q_bank_list_tile.dart';
class MDCAT extends StatefulWidget {
  const MDCAT({super.key});

  @override
  State<MDCAT> createState() => _MDCATState();
}

class _MDCATState extends State<MDCAT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions',
          style: GoogleFonts.rubik(
              fontSize: 34,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'MDCAT, NUMS, and Private Universities Question Bank',
              style: GoogleFonts.rubik(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 20,),
            QListTile(title: 'Chapter-Wise', onTap: () {}, imageAddress: 'assets/chapterwise.png',),
            const SizedBox(height: 20,),
            QListTile(title: 'Yearly Past Papers', onTap: () {}, imageAddress: 'assets/past_paper.png'),
            const SizedBox(height: 20,),
            QListTile(title: 'Self-Assessment Mocks', onTap: () {}, imageAddress: 'assets/mocks.png',),
            const SizedBox(height: 20,),
            QListTile(title: 'Test Sessions', onTap: () {}, imageAddress: 'assets/premedtt.png',),
            const SizedBox(height: 20,),
            QListTile(title: 'Saved Questions', onTap: () {}, imageAddress: 'assets/vector.png',),
          ],
        ),
      ),
    );
  }
}
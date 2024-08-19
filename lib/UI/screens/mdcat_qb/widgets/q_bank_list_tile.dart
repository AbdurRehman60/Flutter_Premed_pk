import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class QListTile extends StatelessWidget {
  const QListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.imageAddress,
  });

  final String title;
  final void Function() onTap;
  final String imageAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff26000000),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onTap: onTap,
          leading: Image.asset(
            imageAddress,
            height: 30,
          ),
          title: Text(
            title,
            style: GoogleFonts.rubik(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          trailing: SvgPicture.asset(
            'assets/forward_icon.svg',
            height: 18,
          ),
        ),
      ),
    );
  }
}
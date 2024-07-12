// ignore_for_file: use_colored_box

import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/mnemonics/mnemonics_grid_builder.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class MnemonicsHome extends StatefulWidget {
  const MnemonicsHome({super.key});

  @override
  State<MnemonicsHome> createState() => _MnemonicsHomeState();
}

class _MnemonicsHomeState extends State<MnemonicsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF0F3),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            title: Text(
              'The Vault',
              style: PreMedTextTheme()
                  .heading1
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            backgroundColor: const Color(0xFFFBF0F3),
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: PreMedColorTheme().primaryColorRed),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF80239F),
                    Color(0xFFB43483),
                    Color(0xFFFE8B83)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Image.asset(
                        'assets/images/vault/Avatar (1).png',
                        fit: BoxFit.contain,
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBoxes.vertical10Px,
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Pre',
                        style: PreMedTextTheme().heading1.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                    TextSpan(
                        text: 'M',
                        style: PreMedTextTheme().heading1.copyWith(
                            color: PreMedColorTheme().primaryColorRed,
                            fontWeight: FontWeight.w800,
                            fontSize: 15)),
                    TextSpan(
                        text: 'ed Mnemonics',
                        style: PreMedTextTheme().heading1.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 15)),
                  ],
                ),
              ),
            ),
            SizedBoxes.vertical3Px,
            Text(
              'Education',
              style: PreMedTextTheme().heading1.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: PreMedColorTheme().neutral650),
            ),
            SizedBoxes.vertical3Px,
            Text(
              'No pointless cramming anymore. Now learn things smartly by PreMed Mnemonics!',
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: PreMedTextTheme().heading1.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: PreMedColorTheme().black),
            ),
            SizedBoxes.vertical3Px,
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Followed by ',
                      style: PreMedTextTheme().heading1.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: PreMedColorTheme().black)),
                  TextSpan(
                      text: '@Pre',
                      style: PreMedTextTheme()
                          .heading1
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 15)),
                  TextSpan(
                      text: 'M',
                      style: PreMedTextTheme().heading1.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.w800,
                          fontSize: 15)),
                  TextSpan(
                      text: 'ed.pk',
                      style: PreMedTextTheme()
                          .heading1
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 15)),
                ],
              ),
            ),
            SizedBoxes.vertical3Px,
            const MnemonicsGridBuilder()
          ],
        ),
      ),
    );
  }
}

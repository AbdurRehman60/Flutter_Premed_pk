import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';

import '../../../../constants/constants_export.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const PopButton(),
        title: Container(
          padding: const EdgeInsets.only(
            top: 3,
          ),
          child: AppBar(
            backgroundColor: PreMedColorTheme().background,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credits',
                      style: PreMedTextTheme().heading6.copyWith(
                            color: PreMedColorTheme().black,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBoxes.vertical2Px,
                    Text(
                      'settings'.toUpperCase(),
                      style: PreMedTextTheme().subtext.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: PreMedColorTheme().black,
                          ),
                    )
                  ],
                ),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        backgroundColor: PreMedColorTheme().background,
      ),
      backgroundColor: PreMedColorTheme().background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Section(
              title: 'The Founders',
              names: [
                'Hasnain Mankani  |  Fahd Niaz Shaikh',
              ],
            ),
            const Section(
              title: 'Designed by',
              names: [
                'Fateh Alam Bhatty',
              ],
            ),
            const Section(
              title: 'The Developers (App)',
              names: [
                'Usama Umar',
                'Saneha Gill',
                'Abdu R Rehman',
                'Bilal Tariq'
              ],
            ),
            const Section(
              title: 'The Developers (WEB)',
              names: [
                'Salis Salman',
                'Hasan Muarad',
                'Abrar Ahmed',
                'Kishore Kumar',
                'Izhan Ahmed',
              ],
            ),
            Section(
              title: 'The Testers',
              names: List.filled(10, 'Johnny Appleseed'),
            ),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.names});
  final String title;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: PreMedTextTheme().body.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        SizedBoxes.vertical10Px,
        for (final name in names)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              name,
              style: PreMedTextTheme()
                  .body
                  .copyWith(fontSize: 14, color: Colors.black),
            ),
          ),
        SizedBoxes.verticalBig,
      ],
    );
  }
}

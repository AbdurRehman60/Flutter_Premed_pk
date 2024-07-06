import 'package:premedpk_mobile_app/UI/screens/mocks/mdcat_mocks/mdcat_mocks_home.dart';
import 'package:premedpk_mobile_app/UI/screens/mocks/nums_mocks/nums_mocks.dart';
import 'package:premedpk_mobile_app/UI/screens/mocks/pu_mocks/pu_mocks_home.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/mdcat/mocks&bank_statistics.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import '../home/widgets/notes_tile.dart';

class MocksHome extends StatelessWidget {
  const MocksHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: PreMedColorTheme().white,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MDcatMockorBankStats(),
                  ),
                );
              },
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mocks',
                  style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: NotesTile(
                  heading: "MDCAT Mocks",
                  description: "Go to MDCAT Mocks",
                  icon: PremedAssets.QuestionBank,
                  bgColor: PreMedColorTheme().white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MdcatMocksHome()),
                    );
                  },
                ),
              ),
              SizedBoxes.verticalMedium,
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: NotesTile(
                  heading: "Private Universities Mocks",
                  description: "Go to Private Universities Mocks",
                  icon: PremedAssets.QuestionBank,
                  bgColor: PreMedColorTheme().white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivuniMocksHome()),
                    );
                  },
                ),
              ),
              SizedBoxes.verticalMedium,
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: NotesTile(
                  heading: "NUMS Mocks",
                  description: "Go to Nums Mocks",
                  icon: PremedAssets.QuestionBank,
                  bgColor: PreMedColorTheme().white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NumsMocksHome()),
                    );
                  },
                ),
              ),
              // Material(
              //   elevation: 3,
              //   borderRadius: BorderRadius.circular(15),
              //   child: NotesTile(
              //     heading: "MdCatQbank",
              //     description:
              //     "Go to Private MdCatQbank",
              //     icon: PremedAssets.QuestionBank,
              //     bgColor: PreMedColorTheme().white,
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => const MdcatQbankHome()),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}

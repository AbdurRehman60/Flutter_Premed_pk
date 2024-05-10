import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/qbank_ground.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class BankOrMocks extends StatefulWidget {
  BankOrMocks({super.key, required this.bankName});
  final String bankName;

  @override
  State<BankOrMocks> createState() => _BankOrMocksState();
}

class _BankOrMocksState extends State<BankOrMocks> {
  late String bank;

  late String mock;

  late String deckGroupName;

  void getBankorMock() {
    if (widget.bankName == 'MDCAT QBank') {
      setState(() {
        bank = 'MDCAT QBank';
        mock = '';
        deckGroupName = 'MDCAT QBANK';
      });
    } else if (widget.bankName == 'NUMS QBank') {
      setState(() {
        bank = 'NUMS QBank';
        mock = '';
        deckGroupName = 'NUMS QBANK';
      });
    } else {
      setState(() {
        bank = 'Private Universities QBank';
        mock = '';
        deckGroupName = 'PU Qbank';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getBankorMock();
    print(bank);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: const SizedBox(
              height: 37,
              width: 37,
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFFEC5863),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Text(widget.bankName,
              style: PreMedTextTheme()
                  .heading2
                  .copyWith(fontSize: 34, fontWeight: FontWeight.w800)),
          SizedBoxes.horizontal2Px,
          Text('Past Papers, Mocks and Original Practice Questions',
              style: PreMedTextTheme()
                  .heading2
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w400)),
          SizedBoxes.horizontal12Px,
          BankMockCard(
            Name: 'Question Banks',
            imagePath: 'imagePath',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Qbank(
                            deckCategory: bank,
                            deckGroupName: deckGroupName,
                          )));
            },
          ),
          SizedBoxes.horizontal12Px,
          BankMockCard(
            Name: 'Mocks',
            imagePath: 'imagePath',
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class BankMockCard extends StatelessWidget {
  const BankMockCard(
      {super.key,
      required this.Name,
      required this.imagePath,
      required this.onTap});
  final String Name;
  final String imagePath;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Name,
                  style: PreMedTextTheme()
                      .heading2
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

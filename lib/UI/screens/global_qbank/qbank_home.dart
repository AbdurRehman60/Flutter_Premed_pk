import 'package:flutter/cupertino.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/qbank_ground.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';

class QbankHome extends StatelessWidget {
  const QbankHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi,Usama',
                style: PreMedTextTheme()
                    .heading2
                    .copyWith(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              SizedBoxes.verticalMedium,
              Text(
                'Ready to continue our journey?',
                style: PreMedTextTheme().heading6.copyWith(fontSize: 17),
              ),
              SizedBoxes.verticalMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BankCard(
                      image: 'assets/images/MDCAT QBank.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Qbank(
                                      deckCategory: 'MDCAT QBank',
                                      deckGroupName: 'MDCAT QBANK',
                                    )));
                      }),
                  BankCard(
                      image: 'assets/images/NUMS qbank.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Qbank(
                                      deckCategory: 'NUMS QBank',
                                      deckGroupName: 'NUMS QBANK',
                                    )));
                      }),
                  BankCard(
                      image: 'assets/images/pu_qbank.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Qbank(
                                    deckGroupName: 'PU Qbank',
                                    deckCategory:
                                        'Private Universities QBank')));
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BankCard extends StatelessWidget {
  const BankCard({super.key, required this.image, required this.onTap});
  final String image;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(image),
          )),
    );
  }
}

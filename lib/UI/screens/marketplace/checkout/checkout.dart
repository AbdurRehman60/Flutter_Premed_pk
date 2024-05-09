// ignore_for_file: use_setters_to_change_properties

import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/payment_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/payment_video_youtube.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

final Map<String, dynamic> meezanNumbers = {
  'IBAN #': 'PK50MEZN0099170105642737',
  'Fahad Niaz Sheikh': '99170105642737'
};

final Map<String, dynamic> hblNumbers = {
  'MOHD HASNAIN': '05417988872303',
  'IBAN #': "PK90HABB0005417988872303"
};

final Map<String, dynamic> easyPaisaNumbers = {
  'ABBAS ALI MANKANI': '0336-2541727',
  'Fahd Niaz Shaikh': '0336-2542685',
};

final Map<String, dynamic> jazzCashNumbers = {
  'PreMedPK': '0302-8609690',
  'Khwaja Muhammed Heean': '0331-2176647',
};

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
  });

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final RadioGroup<int> paymentRadioGroup = RadioGroup<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment',
              style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black, fontWeight: FontWeight.bold),
            ),
            SizedBoxes.vertical2Px,
            Text('CHOOSE METHOD OF PAYMENT',
                style: PreMedTextTheme().subtext.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: PreMedColorTheme().black,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              PaymentTile(
                transferAmountText: 'Transfer the Grand Total to one of these Bank Accounts, the details of which are provided below. Then upload the Paid Receipt below.',
                selected: paymentRadioGroup.selectedValue == 0,
                paymentProvider: "Meezan Bank",
                image: PremedAssets.Meezan,
                numbers: meezanNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 0
                        ? paymentRadioGroup.setSelectedValue(0)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                transferAmountText: 'Transfer the Grand Total to one of these Bank Accounts, the details of which are provided below. Then upload the Paid Receipt below.',
                selected: paymentRadioGroup.selectedValue == 1,
                paymentProvider: "Habib Bank Limited",
                image: PremedAssets.HBL,
                numbers: hblNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 1
                        ? paymentRadioGroup.setSelectedValue(1)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                transferAmountText: 'Transfer the Grand Total to the one of the following Easypaisa Accounts, the details of which are provided below. Then upload the Paid Receipt below.',
                selected: paymentRadioGroup.selectedValue == 2,
                paymentProvider: "Easy Paisa",
                image: PremedAssets.EasyPaisa,
                numbers: easyPaisaNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 2
                        ? paymentRadioGroup.setSelectedValue(2)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                transferAmountText: 'Transfer the Grand Total to one of the following JazzCash Accounts, the details of which are provided below. Then upload the Paid Receipt below.',
                selected: paymentRadioGroup.selectedValue == 3,
                paymentProvider: "Jazz Cash",
                image: PremedAssets.JazzCash,
                numbers: jazzCashNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 3
                        ? paymentRadioGroup.setSelectedValue(3)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How to pay',
                        style: PreMedTextTheme().heading5,
                      ),
                      Text(
                        'Zoom-in to view',
                        style: PreMedTextTheme().headline.copyWith(
                            color: PreMedColorTheme().neutral400,
                            fontWeight: FontWeights.regular),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: PreMedColorTheme().neutral300,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(8.0),
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Image.asset(
                          PremedAssets.HowtoPay,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PreMedColorTheme().primaryColorBlue,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            clipBehavior: Clip.hardEdge,
            context: context,
            builder: (BuildContext context) {
              return const PaymentVideo();
            },
          );
        },
        child: const Icon(Icons.help_outline_outlined),
      ),
    );
  }
}

class RadioGroup<T> {
  T? _selectedValue;

  T? get selectedValue => _selectedValue;

  void setSelectedValue(T? value) {
    _selectedValue = value;
  }
}
